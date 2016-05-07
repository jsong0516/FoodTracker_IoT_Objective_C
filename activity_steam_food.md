# Activity Streams - Food

##  Introduction
<a name="introduction" />
This document presents and defines Object types and Verbs for Activity Streams for Food App which will be developed for INFO 290: Internet of Things at University of California, Berkeley.

## Verbs
<a name="verbs" />
This specification defines the following core verbs in addition to the default <tt>post</tt> verb that is defined in Section 6 of [activitystreams][activitystreams]:

<table border="1">
  <tr><th align="left" width="5%">Verb</th><th width="50%" align="left">Description</th><th align="left" nowrap="nowrap">Example</th></tr>
  <tr>
    <td align="center"><tt>eat</tt></td>
    <td>Indicates that the actor has ate the object. For instance, a person eating a food.</td>
    <td nowrap="nowrap">
      <pre>
{
  "actor": {
    "objectType": "person",
    "displayName": "Byung Gon Song"},
  "verb": "eat",
  "object": {
    "objectType": "food",
    “displayName”: “hamburger”}
}
      </pre>
    </td>
  </tr>
  <tr>
    <td align="center"><tt>consume</tt></td>
    <td>Indicates that the actor has consumed the calories of the object. For instance, a person consuming a calories of the object.</td>
    <td>
      <pre>
{
  "actor": {
    "objectType": "person",
    "displayName": "Aldrich Ong"},
  "verb": "consumed",
    "object": {
      "objectType": "calories",
      “displayName”: "700"}
}
      </pre>
    </td>
  </tr>
  <tr>
    <td align="center"><tt>add</tt></td>
    <td>Indicates that the actor has added the object to the target. For instance, adding calories to the collection of food diary. </td>
    <td>
      <pre>
  {
    "actor": {
      "objectType": "person", 
      "displayName": "Byung Gon Song"},
    "verb": "add",
    "object": {
      "objectType": "calories", 
      "content": 700},
    "target": {
      "objectType": "collection",
      "displayName": "Byung's Eating Diary",
      "objectTypes": ["calories"]
    }
  }
      </pre>
    </td>
  </tr>
  
  <tr>
    <td align="center"><tt>publish</tt></td>
    <td> Publish something. For an example, publish contents of diary. </td>
    <td>
      <pre>
  {
    "actor": {
      "objectType": "person", 
      "displayName": "Byung Gon Song"},
    "verb": "publish",
    "object": {
      "objectType": "collection", 
      "displayName": [300 200 300]
    }
  }
      </pre>
    </td>
  </tr>
  
  <tr>
    <td align="center"><tt>burned</tt></td>
    <td>Indicates that the actor has burned some calories. </td>
    <td>
      <pre>
  {
    "actor": {
      "objectType": "person", 
      "displayName": "Byung Gon Song"},
    "verb": "burned",
    "object": {
      "objectType": "calories", 
      "content": 700}
  }
      </pre>
    </td>
  </tr>
  
</table>

## Object Types
<a name="object-types" />
The table contains the core set of common objectTypes in addition to the "activity" objectType defined in Section 7 of [activitystreams][activitystreams].

All Activity Stream Objects inherit the same fundamental set of basic properties as defined in section 3.4 of [activitystreams][activitystreams].  In addition to these, objects of any specific type are permitted to introduce additional optional or required properties that are meaningful to objects of that type.

<table border="1">
  <tr><th align="left">Object Type</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>food</tt></td>
    <td>Represents any kind of food object.</td>
  </tr>
  <tr>
    <td><tt>calories</tt></td>
    <td>Represents calories of food.</td>
  </tr>
  <tr>
  <td><tt>collection</tt></td>
  <td>Represents a generic collection of objects of any type. This object type can be used, for instance, to represent a collection of files like a folder; a collection of photos like an album; and so forth. Objects of this type MAY contain an additional objectTypes property whose value is an Array of Strings specifying the expected objectType of objects contained within the collection.</td>
  </tr>

</table>


## Object Properties

### actor

#### http://activitystrea.ms/specs/json/1.0/#activity

Describes the entity that performed the activity. An activity MUST contain one actor property whose value is a single Object.


### content 

#### http://activitystrea.ms/specs/json/1.0/#activity

Natural-language description of the activity encoded as a single JSON String containing HTML markup. Visual elements such as thumbnail images MAY be included. An activity MAY contain a content property.

## Comments
We are re-using 'add' verb and 'collection' object type from https://github.com/activitystreams/activity-schema/blob/master/activity-schema.md because other apps consume such Activity Steams might able to consume our Activity Steam as well.

Our "eat" verb can possibly used for nofication of the actor's meals to a external application. 


## License

As of [date], the following persons or entities have made this Specification available under the Open Web Foundation Agreement Version 1.0, which is available at http://www.openwebfoundation.org/legal/.

[List of persons or entities]

You can review the signed copies of the Open Web Foundation Agreement Version 1.0 for this Specification at http://activitystrea.ms/licensing/, which may also include additional parties to those listed above.

Your use of this Specification may be subject to other third party rights. THIS SPECIFICATION IS PROVIDED "AS IS." The contributors expressly disclaim any warranties (express, implied, or otherwise), including implied warranties of merchantability, non-infringement, fitness for a particular purpose, or title, related to the Specification. The entire risk as to implementing or otherwise using the Specification is assumed by the Specification implementer and user. IN NO EVENT WILL ANY PARTY BE LIABLE TO ANY OTHER PARTY FOR LOST PROFITS OR ANY FORM OF INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES OF ANY CHARACTER FROM ANY CAUSES OF ACTION OF ANY KIND WITH RESPECT TO THIS SPECIFICATION OR ITS GOVERNING AGREEMENT, WHETHER BASED ON BREACH OF CONTRACT, TORT (INCLUDING NEGLIGENCE), OR OTHERWISE, AND WHETHER OR NOT THE OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## Normative References
<a name="references" />

 * RFC 1951 - ["DEFLATE Compressed Data Format Specification version 1.3"][RFC1951]
 * RFC 1952 - ["GZIP file format specification version 4.3"][RFC1952]
 * RFC 2119 - ["Key words for use in RFCs to Indicate Requirement Levels"][RFC2119]
 * RFC 3339 - ["Date and Time on the Internet: Timestamps"][RFC3339]
 * RFC 3986 - ["Uniform Resource Identifier (URI): Generic Syntax"][RFC3986]
 * RFC 3987 - ["Internationalized Resource Identifiers (IRIs)"][RFC3987]
 * RFC 4627 - ["The application/json Media Type for JavaScript Object Notation (JSON)"][RFC4627]
 * RFC 4646 - ["Tags for Identifying Languages"][RFC4646]
 * RFC 5988 - ["Web Linking"][RFC5988]
 * ["JSON Activity Streams v1.0"][activitystreams]

[RFC1951]: http://www.ietf.org/rfc/rfc1951.txt "DEFLATE Compressed Data Format Specification version 1.3"
[RFC1952]: http://www.ietf.org/rfc/rfc1952.txt "GZIP file format specification version 4.3"
[RFC2119]: http://www.ietf.org/rfc/rfc1952.txt "Key words for use in RFCs to Indicate Requirement Levels"
[RFC3339]: http://www.ietf.org/rfc/rfc3339.txt "Date and Time on the Internet: Timestamps"
[RFC3986]: http://www.ietf.org/rfc/rfc3986.txt "Uniform Resource Identifier (URI): Generic Syntax"
[RFC3987]: http://www.ietf.org/rfc/rfc3987.txt "Internationalized Resource Identifiers (IRIs)"
[RFC4627]: http://www.ietf.org/rfc/rfc4627.txt "The application/json Media Type for JavaScript Object Notation (JSON)"
[RFC4646]: http://www.ietf.org/rfc/rfc4646.txt "Tags for Identifying Languages"
[RFC5988]: http://www.ietf.org/rfc/rfc5988.txt "Web Linking"
[activitystreams]: http://activitystrea.ms/specs/json/1.0/ "JSON Activity Streams v1.0"

[1]: http://dublincore.org "Dublin Core"
[2]: http://www.geojson.org/geojson-spec.html "GeoJSON"
[3]: http://json-ld.org/ "JSON-LD"
[4]: http://www.iana.org/assignments/link-relations/link-relations.xml "Link Relations"
[5]: http://www.odata.org/ "OData"
[6]: https://developers.facebook.com/docs/opengraph/ "OpenGraph"
[7]: http://schema.org "Schema.org"

