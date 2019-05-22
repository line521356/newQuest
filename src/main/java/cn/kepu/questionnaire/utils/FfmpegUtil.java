package cn.kepu.questionnaire.utils;

import org.bytedeco.javacpp.*;
import org.bytedeco.javacv.*;

import javax.swing.*;
import java.io.IOException;
import java.util.Date;

import static org.bytedeco.javacpp.avcodec.*;
import static org.bytedeco.javacpp.avformat.*;
import static org.bytedeco.javacpp.avutil.*;
import static org.bytedeco.javacpp.swscale.SWS_BICUBIC;
import static org.bytedeco.javacpp.swscale.sws_getContext;
import static org.bytedeco.javacpp.swscale.sws_scale;

public class FfmpegUtil {

    public static boolean isStart = true;

    /**
     * 按帧录制视频
     *
     * @param inputFile-该地址可以是网络直播/录播地址，也可以是远程/本地文件路径
     * @param outputFile                              -该地址只能是文件地址，如果使用该方法推送流媒体服务器会报错，原因是没有设置编  码格式
     * @throws org.bytedeco.javacv.FrameRecorder.Exception
     */
    public static void frameRecord(String inputFile, String outputFile, int audioChannel)
            throws Exception, org.bytedeco.javacv.FrameRecorder.Exception {

        // 获取视频源
        FFmpegFrameGrabber grabber = new FFmpegFrameGrabber(inputFile);
        // 流媒体输出地址，分辨率（长，高），是否录制音频（0:不录制/1:录制）
        FFmpegFrameRecorder recorder = new FFmpegFrameRecorder(outputFile, 1280, 720, audioChannel);
        recorder.setVideoCodec(avcodec.AV_CODEC_ID_H264);
        System.out.println("录制视频nnnn");
        // 开始取视频源
        recordByFrame(grabber, recorder);

    }

    private static void recordByFrame(FFmpegFrameGrabber grabber, FFmpegFrameRecorder recorder)
            throws Exception, org.bytedeco.javacv.FrameRecorder.Exception {
        try {//建议在线程中使用该方法
            grabber.start();
            recorder.start();
            Frame frame = null;
            Date beginTime = new Date();
            while (isStart && (frame = grabber.grabFrame()) != null && new Date().getTime() - beginTime.getTime() <= 5 * 60 * 1000) {
                recorder.record(frame);
            }
            recorder.stop();
            grabber.stop();
        } finally {
            if (grabber != null) {
                grabber.stop();
            }
        }
    }

    /**
     *      * 打开视频流或者视频文件，并解码视频帧为YUVJ420P数据
     *      *
     *      * @param url -视频源地址
     *      * @param out_file 截图文件保存地址
     *      * @author eguid
     *      * @throws IOException
     *     
     */
    public static int saveVideoPic(String url, String out_file) throws IOException {
        avformat.AVFormatContext pFormatCtx = new avformat.AVFormatContext(null);
        int i, videoStream;
        avcodec.AVCodecContext pCodecCtx = null;
        avcodec.AVCodec pCodec = null;
        avutil.AVFrame pFrame = null;
        avcodec.AVPacket packet = new avcodec.AVPacket();
        int[] frameFinished = new int[1];
        avutil.AVDictionary optionsDict = null;

        avutil.AVFrame pFrameRGB = null;
        int numBytes;
        BytePointer buffer = null;
        swscale.SwsContext sws_ctx = null;

        if (avformat_open_input(pFormatCtx, url, null, null) != 0) {
            return -1; // Couldn't open file
        }

        if (avformat_find_stream_info(pFormatCtx, (PointerPointer<Pointer>) null) < 0) {
            return -1;// Couldn't find stream information
        }

        av_dump_format(pFormatCtx, 0, url, 0);// Dump information about file onto standard error

        videoStream = -1;
        for (i = 0; i < pFormatCtx.nb_streams(); i++) {
            if (pFormatCtx.streams(i).codec().codec_type() == AVMEDIA_TYPE_VIDEO) {
                videoStream = i;
                break;
            }
        }
        if (videoStream == -1) {
            return -1; // Didn't find a video stream
        }

        pCodecCtx = pFormatCtx.streams(videoStream).codec();

        pCodec = avcodec_find_decoder(pCodecCtx.codec_id());
        if (pCodec == null) {
            System.err.println("Unsupported codec!");
            return -1; // Codec not found
        }
        if (avcodec_open2(pCodecCtx, pCodec, optionsDict) < 0) {
            return -1; // Could not open codec
        }

        pFrame = av_frame_alloc();// Allocate video frame

        pFrameRGB = av_frame_alloc();
        if (pFrameRGB == null) {
            return -1;
        }
        int width = pCodecCtx.width(), height = pCodecCtx.height();
        pFrameRGB.width(width);
        pFrameRGB.height(height);
        pFrameRGB.format(AV_PIX_FMT_YUVJ420P);
        // Determine required buffer size and allocate buffer
        numBytes = avpicture_get_size(AV_PIX_FMT_YUVJ420P, width, height);
        buffer = new BytePointer(av_malloc(numBytes));
        sws_ctx = sws_getContext(pCodecCtx.width(), pCodecCtx.height(), pCodecCtx.pix_fmt(), pCodecCtx.width(), pCodecCtx.height(), AV_PIX_FMT_YUVJ420P, SWS_BICUBIC, null, null, (DoublePointer) null);

        // Assign appropriate parts of buffer to image planes in pFrameRGB
        // Note that pFrameRGB is an AVFrame, but AVFrame is a superset
        // of AVPicture
        avpicture_fill(new avcodec.AVPicture(pFrameRGB), buffer, AV_PIX_FMT_YUVJ420P, pCodecCtx.width(), pCodecCtx.height());

        int ret = -1;
        while (av_read_frame(pFormatCtx, packet) >= 0) {
            if (packet.stream_index() == videoStream) {// Is this a packet from the video stream?
                avcodec_decode_video2(pCodecCtx, pFrame, frameFinished, packet);// Decode video frame

                if (frameFinished != null) {
                    sws_scale(sws_ctx, pFrame.data(), pFrame.linesize(), 0, pCodecCtx.height(), pFrameRGB.data(), pFrameRGB.linesize());
                }

                if (frameFinished[0] != 0 && !pFrame.isNull()) {
                    sws_scale(sws_ctx, pFrame.data(), pFrame.linesize(), 0, pCodecCtx.height(), pFrameRGB.data(), pFrameRGB.linesize());
                    if ((ret = saveImg(pFrameRGB, out_file)) >= 0) {
                        break;
                    }
                }
            }

        }
        av_free_packet(packet);// Free the packet that was allocated by av_read_frame
        // Free the RGB image
        av_free(buffer);

        av_free(pFrameRGB);

        av_free(pFrame);// Free the YUV frame

        avcodec_close(pCodecCtx);// Close the codec

        avformat_close_input(pFormatCtx);// Close the video file

        return ret;
    }

    /**
     *  * 把YUVJ420P数据编码保存成jpg图片
     *  *
     *  * @param pFrame -图像帧
     *  * @param out_file -截图文件保存地址
     *  * @author eguid
     *  * @return
     *     
     */
    private static int saveImg(AVFrame pFrame, String out_file) {

        av_log_set_level(AV_LOG_ERROR);
        AVPacket pkt = null;
        AVStream pAVStream = null;
        AVCodec codec = null;
        int ret = -1;

        int width = pFrame.width(), height = pFrame.height();
        // 分配AVFormatContext对象
        AVFormatContext pFormatCtx = avformat_alloc_context();
        // 设置输出文件格式
        pFormatCtx.oformat(av_guess_format("mjpeg", null, null));
        if (pFormatCtx.oformat() == null) {
            return -1;
        }
        try {
            // 创建并初始化一个和该url相关的AVIOContext
            AVIOContext pb = new AVIOContext();
            if (avio_open(pb, out_file, AVIO_FLAG_READ_WRITE) < 0) {// dont open file
                return -1;
            }
            pFormatCtx.pb(pb);
            // 构建一个新stream
            pAVStream = avformat_new_stream(pFormatCtx, codec);
            if (pAVStream == null) {
                return -1;
            }
            int codec_id = pFormatCtx.oformat().video_codec();
            // 设置该stream的信息
            // AVCodecContext pCodecCtx = pAVStream.codec();
            AVCodecContext pCodecCtx = pAVStream.codec();
            pCodecCtx.codec_id(codec_id);
            pCodecCtx.codec_type(AVMEDIA_TYPE_VIDEO);
            pCodecCtx.pix_fmt(AV_PIX_FMT_YUVJ420P);
            pCodecCtx.width(width);
            pCodecCtx.height(height);
            pCodecCtx.time_base().num(1);
            pCodecCtx.time_base().den(25);

            // Begin Output some information
            av_dump_format(pFormatCtx, 0, out_file, 1);
            // End Output some information

            // 查找解码器
            AVCodec pCodec = avcodec_find_encoder(codec_id);
            if (pCodec == null) {// codec not found
                return -1;
            }
            // 设置pCodecCtx的解码器为pCodec
            if (avcodec_open2(pCodecCtx, pCodec, (PointerPointer<Pointer>) null) < 0) {
                System.err.println("Could not open codec.");
                return -1;
            }

            // Write Header
            avformat_write_header(pFormatCtx, (PointerPointer<Pointer>) null);

            // 给AVPacket分配足够大的空间
            pkt = new AVPacket();
            if (av_new_packet(pkt, width * height * 3) < 0) {
                return -1;
            }
            int[] got_picture = {0};
            // encode
            if (avcodec_encode_video2(pCodecCtx, pkt, pFrame, got_picture) >= 0) {
                // flush
                if ((ret = av_write_frame(pFormatCtx, pkt)) >= 0) {
                    // Write Trailer
                    if (av_write_trailer(pFormatCtx) >= 0) {
                        System.err.println("Encode Successful.");
                    }
                }
            }
            return ret;
            // 结束时销毁
        } finally {
            if (pkt != null) {
                av_free_packet(pkt);
            }
            if (pAVStream != null) {
                avcodec_close(pAVStream.codec());
            }
            if (pFormatCtx != null) {
                avio_close(pFormatCtx.pb());
                avformat_free_context(pFormatCtx);
            }
        }
    }

    public static void recordPush(String inputFile,String outputFile,int v_rs) throws Exception, org.bytedeco.javacv.FrameRecorder.Exception, InterruptedException {
        Loader.load(opencv_objdetect.class);
        long startTime = 0;
        FrameGrabber grabber = FFmpegFrameGrabber.createDefault(inputFile);
        try {
            grabber.start();
        } catch (Exception e) {
            try {
                grabber.restart();
            } catch (Exception e1) {
                throw e;
            }
        }

        OpenCVFrameConverter.ToIplImage converter = new OpenCVFrameConverter.ToIplImage();
        Frame grabframe = grabber.grab();
        opencv_core.IplImage grabbedImage = null;
        if (grabframe != null) {
            System.out.println("取到第一帧");
            grabbedImage = converter.convert(grabframe);
        } else {
            System.out.println("没有取到第一帧");
        }
        FrameRecorder recorder;
        try {
            recorder = FrameRecorder.createDefault(outputFile, 1280, 720);
        } catch (org.bytedeco.javacv.FrameRecorder.Exception e) {
            throw e;
        }
        recorder.setVideoCodec(avcodec.AV_CODEC_ID_H264);
        recorder.setFormat("flv");
        recorder.setFrameRate(v_rs);
        recorder.setGopSize(v_rs);
        System.out.println("准备开始推流...");
        try {
            recorder.start();
        } catch (org.bytedeco.javacv.FrameRecorder.Exception e) {
            try {
                System.out.println("录制器启动失败，正在重新启动...");
                if (recorder != null) {
                    System.out.println("尝试关闭录制器");
                    recorder.stop();
                    System.out.println("尝试重新开启录制器");
                    recorder.start();
                }

            } catch (org.bytedeco.javacv.FrameRecorder.Exception e1) {
                throw e;
            }
        }
        System.out.println("开始推流");

        while ((grabframe = grabber.grab()) != null) {

                grabbedImage = converter.convert(grabframe);
                Frame rotatedFrame = converter.convert(grabbedImage);

                if (startTime == 0) {
                    startTime = System.currentTimeMillis();
                }
                recorder.setTimestamp(1000 * (System.currentTimeMillis() - startTime));//时间戳
                if (rotatedFrame != null) {
                    recorder.record(rotatedFrame);
                }

                Thread.sleep(40);
            }

            recorder.stop();
            recorder.release();
            grabber.stop();
            System.exit(2);


    }
    public static void main(String[] args) {
        String inputFile = "rtsp://admin:GYDHJM@192.168.124.12:554/h264/ch1/main/av_stream";

        String outputFile = "rtmp://localhost/live/192.168.124.12";

        try {
            recordPush(inputFile, outputFile,25);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


}
