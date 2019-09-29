// To parse this JSON data, do
//
//     final cloudinaryUploadImageModel = cloudinaryUploadImageModelFromJson(jsonString);

import 'dart:convert';

CloudinaryUploadImageModel cloudinaryUploadImageModelFromJson(String str) => CloudinaryUploadImageModel.fromJson(json.decode(str));

String cloudinaryUploadImageModelToJson(CloudinaryUploadImageModel data) => json.encode(data.toJson());

class CloudinaryUploadImageModel {
    String publicId;
    dynamic version;
    int width;
    int height;
    dynamic format;
    DateTime createdAt;
    dynamic resourceType;
    List<dynamic> tags;
    int bytes;
    dynamic type;
    dynamic etag;
    String url;
    String secureUrl;
    String signature;
    String originalFilename;

    CloudinaryUploadImageModel({
        this.publicId,
        this.version,
        this.width,
        this.height,
        this.format,
        this.createdAt,
        this.resourceType,
        this.tags,
        this.bytes,
        this.type,
        this.etag,
        this.url,
        this.secureUrl,
        this.signature,
        this.originalFilename,
    });

    factory CloudinaryUploadImageModel.fromJson(Map<String, dynamic> json) => CloudinaryUploadImageModel(
        publicId: json["public_id"] == null ? null : json["public_id"],
        version: json["version"] == null ? null : json["version"],
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        format: json["format"] == null ? null : json["format"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        resourceType: json["resource_type"] == null ? null : json["resource_type"],
        tags: json["tags"] == null ? null : List<dynamic>.from(json["tags"].map((x) => x)),
        bytes: json["bytes"] == null ? null : json["bytes"],
        type: json["type"] == null ? null : json["type"],
        etag: json["etag"] == null ? null : json["etag"],
        url: json["url"] == null ? null : json["url"],
        secureUrl: json["secure_url"] == null ? null : json["secure_url"],
        signature: json["signature"] == null ? null : json["signature"],
        originalFilename: json["original_filename"] == null ? null : json["original_filename"],
    );

    Map<String, dynamic> toJson() => {
        "public_id": publicId == null ? null : publicId,
        "version": version == null ? null : version,
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "format": format == null ? null : format,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "resource_type": resourceType == null ? null : resourceType,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
        "bytes": bytes == null ? null : bytes,
        "type": type == null ? null : type,
        "etag": etag == null ? null : etag,
        "url": url == null ? null : url,
        "secure_url": secureUrl == null ? null : secureUrl,
        "signature": signature == null ? null : signature,
        "original_filename": originalFilename == null ? null : originalFilename,
    };
}
