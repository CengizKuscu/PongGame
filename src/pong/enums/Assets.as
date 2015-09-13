/**
 * Created by Cengiz on 13.9.2015.
 */
package pong.enums {
public class Assets {

    [Embed(source="../../../resources/font.fnt", mimeType="application/octet-stream")]
    public static const FontXml:Class;

    [Embed(source="../../../resources/font.png")]
    public static const FontTexture:Class;
}
}
