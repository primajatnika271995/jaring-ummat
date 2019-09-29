// To parse this JSON data, do
//
//     final cloudinaryUploadVideoModel = cloudinaryUploadVideoModelFromJson(jsonString);

import 'dart:convert';

CloudinaryUploadVideoModel cloudinaryUploadVideoModelFromJson(String str) => CloudinaryUploadVideoModel.fromJson(json.decode(str));

String cloudinaryUploadVideoModelToJson(CloudinaryUploadVideoModel data) => json.encode(data.toJson());

class CloudinaryUploadVideoModel {
    String publicId;
    int version;
    String signature;
    int width;
    int height;
    String format;
    String resourceType;
    DateTime createdAt;
    List<dynamic> tags;
    int pages;
    int bytes;
    String type;
    String etag;
    bool placeholder;
    String url;
    String secureUrl;
    Audio audio;
    Video video;
    bool isAudio;
    int frameRate;
    int bitRate;
    double duration;
    int rotation;
    String originalFilename;
    int nbFrames;

    CloudinaryUploadVideoModel({
        this.publicId,
        this.version,
        this.signature,
        this.width,
        this.height,
        this.format,
        this.resourceType,
        this.createdAt,
        this.tags,
        this.pages,
        this.bytes,
        this.type,
        this.etag,
        this.placeholder,
        this.url,
        this.secureUrl,
        this.audio,
        this.video,
        this.isAudio,
        this.frameRate,
        this.bitRate,
        this.duration,
        this.rotation,
        this.originalFilename,
        this.nbFrames,
    });

    factory CloudinaryUploadVideoModel.fromJson(Map<String, dynamic> json) => CloudinaryUploadVideoModel(
        publicId: json["public_id"] == null ? null : json["public_id"],
        version: json["version"] == null ? null : json["version"],
        signature: json["signature"] == null ? null : json["signature"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        format: json["format"] == null ? null : json["format"],
        resourceType: json["resource_type"] == null ? null : json["resource_type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        tags: json["tags"] == null ? null : List<dynamic>.from(json["tags"].map((x) => x)),
        pages: json["pages"] == null ? null : json["pages"],
        bytes: json["bytes"] == null ? null : json["bytes"],
        type: json["type"] == null ? null : json["type"],
        etag: json["etag"] == null ? null : json["etag"],
        placeholder: json["placeholder"] == null ? null : json["placeholder"],
        url: json["url"] == null ? null : json["url"],
        secureUrl: json["secure_url"] == null ? null : json["secure_url"],
        audio: json["audio"] == null ? null : Audio.fromJson(json["audio"]),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        isAudio: json["is_audio"] == null ? null : json["is_audio"],
        frameRate: json["frame_rate"] == null ? null : json["frame_rate"],
        bitRate: json["bit_rate"] == null ? null : json["bit_rate"],
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        rotation: json["rotation"] == null ? null : json["rotation"],
        originalFilename: json["original_filename"] == null ? null : json["original_filename"],
        nbFrames: json["nb_frames"] == null ? null : json["nb_frames"],
    );

    Map<String, dynamic> toJson() => {
        "public_id": publicId == null ? null : publicId,
        "version": version == null ? null : version,
        "signature": signature == null ? null : signature,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "format": format == null ? null : format,
        "resource_type": resourceType == null ? null : resourceType,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "pages": pages == null ? null : pages,
        "bytes": bytes == null ? null : bytes,
        "type": type == null ? null : type,
        "etag": etag == null ? null : etag,
        "placeholder": placeholder == null ? null : placeholder,
        "url": url == null ? null : url,
        "secure_url": secureUrl == null ? null : secureUrl,
        "audio": audio == null ? null : audio.toJson(),
        "video": video == null ? null : video.toJson(),
        "is_audio": isAudio == null ? null : isAudio,
        "frame_rate": frameRate == null ? null : frameRate,
        "bit_rate": bitRate == null ? null : bitRate,
        "duration": duration == null ? null : duration,
        "rotation": rotation == null ? null : rotation,
        "original_filename": originalFilename == null ? null : originalFilename,
        "nb_frames": nbFrames == null ? null : nbFrames,
    };
}

class Audio {
    String codec;
    String bitRate;
    int frequency;
    int channels;
    String channelLayout;

    Audio({
        this.codec,
        this.bitRate,
        this.frequency,
        this.channels,
        this.channelLayout,
    });

    factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        codec: json["codec"] == null ? null : json["codec"],
        bitRate: json["bit_rate"] == null ? null : json["bit_rate"],
        frequency: json["frequency"] == null ? null : json["frequency"],
        channels: json["channels"] == null ? null : json["channels"],
        channelLayout: json["channel_layout"] == null ? null : json["channel_layout"],
    );

    Map<String, dynamic> toJson() => {
        "codec": codec == null ? null : codec,
        "bit_rate": bitRate == null ? null : bitRate,
        "frequency": frequency == null ? null : frequency,
        "channels": channels == null ? null : channels,
        "channel_layout": channelLayout == null ? null : channelLayout,
    };
}

class Video {
    String pixFormat;
    String codec;
    int level;
    String profile;
    String bitRate;
    String dar;

    Video({
        this.pixFormat,
        this.codec,
        this.level,
        this.profile,
        this.bitRate,
        this.dar,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        pixFormat: json["pix_format"] == null ? null : json["pix_format"],
        codec: json["codec"] == null ? null : json["codec"],
        level: json["level"] == null ? null : json["level"],
        profile: json["profile"] == null ? null : json["profile"],
        bitRate: json["bit_rate"] == null ? null : json["bit_rate"],
        dar: json["dar"] == null ? null : json["dar"],
    );

    Map<String, dynamic> toJson() => {
        "pix_format": pixFormat == null ? null : pixFormat,
        "codec": codec == null ? null : codec,
        "level": level == null ? null : level,
        "profile": profile == null ? null : profile,
        "bit_rate": bitRate == null ? null : bitRate,
        "dar": dar == null ? null : dar,
    };
}
