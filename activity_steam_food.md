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
    <td align="center"><tt>accept</tt></td>
    <td>Indicates that that the actor has accepted the object. For instance, a person accepting an award, or accepting an assignment.</td>
    <td nowrap="nowrap">
      <pre>
  {
    "actor": {
      "objectType": "person", 
      "displayName": "Sally"},
    "verb": "accept",
    "object": {
      "objectType": "job", 
      "displayName": "Director of Marketing"},
    "title": "Sally accepted the Director of Marketing job."
  }
      </pre>
    </td>
  </tr>
  <tr>
    <td align="center"><tt>access</tt></td>
    <td>Indicates that the actor has accessed the object. For instance, a person accessing a room, or accessing a file.</td>
    <td>
      <pre>
  {
    "actor": {
      "objectType": "person", 
      "displayName": "Joe"},
    "verb": "access",
    "object": {
      "objectType": "file", 
      "displayName": "4Q2012 Sales Forecast.xls"},
    "published": "2012-12-12T12:12:12Z",
    "title": "Joe accessed the file \"4Q2012 Sales Forecast.xls\""
  }
      </pre>
    </td>
  </tr>
  <tr>
    <td align="center"><tt>acknowledge</tt></td>
    <td>Indicates that the actor has acknowledged the object. This effectively signals that the actor is aware of the object's existence.</td>
    <td>
      <pre>
  {
    "actor": {
      "objectType": "person", 
      "displayName": "Sally"},
    "verb": "acknowledge",
    "object": {
      "objectType": "issue", 
      "displayName": "#123: There is a problem with the build"},
    "Sally acknowledged Issue #123"
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
    <td><tt>alert</tt></td>
    <td>Represents any kind of significant notification.</td>
  </tr>
  <tr>
    <td><tt>application</tt></td>
    <td>Represents any kind of software application.</td>
  </tr>
  <tr>
  <td><tt>article</tt></td>
  <td>Represents objects such as news articles, knowledge base entries, or other similar construct. Such objects generally consist of paragraphs of text, in some cases incorporating embedded media such as photos and inline hyperlinks to other resources.</td>
  </tr>
  <tr>
    <td><tt>audio</tt></td>
    <td>Represents audio content of any kind. Objects of this type MAY contain an additional property as specified <a href="#audio-video">here</a>.</td>
  </tr>
  <tr>
    <td><tt>badge</tt></td>
    <td>Represents a badge or award granted to an object (typically a <tt>person</tt> object)</td>
  </tr>
  <tr>
    <td><tt>binary</tt></td>
    <td>Objects of this type are used to carry arbirary Base64-encoded binary data within an Activity Stream object. It is primarily intended to attach binary data to other types of objects through the use of the <tt>attachments</tt> property. Objects of this type will contain the additional properties specified <a href='#binary'>here</a>.</td>
  </tr>
  <tr>
    <td><tt>bookmark</tt></td>
    <td>Represents a pointer to some URL -- typically a web page. In most cases, bookmarks are specific to a given user and contain metadata chosen by that user. Bookmark Objects are similar in principle to the concept of bookmarks or favorites in a web browser. A bookmark represents a pointer to the URL, not the URL or the associated resource itself. Objects of this type SHOULD contain an additional <tt>targetUrl</tt> property whose value is a String containing the IRI of the target of the bookmark.</td>
  </tr>
  <tr>
    <td><tt>collection</tt></td>
    <td>Represents a generic collection of objects of any type. This object type can be used, for instance, to represent a collection of files like a folder; a collection of photos like an album; and so forth. Objects of this type MAY contain an additional <tt>objectTypes</tt> property whose value is an Array of Strings specifying the expected objectType of objects contained within the collection.</td>
  </tr>
  <tr>
    <td><tt>comment</tt></td>
    <td>Represents a textual response to another object. Objects of this type MAY contain an additional <tt>inReplyTo</tt> property whose value is an Array of one or more other Activity Stream Objects for which the object is to be considered a response.</td>
  </tr>
  <tr>
    <td><tt>device</tt></td>
    <td>Represents a device of any type.</td>
  </tr>
  <tr>
    <td><tt>event</tt></td>
    <td>Represents an event that occurs at a certain location during a particular period of time. Objects of this type MAY contain the additional properties specified <a href='#event'>here</a>.</td>
  </tr>
  <tr>
    <td><tt>file</tt></td>
    <td>Represents any form of document or file. Objects of this type MAY contain an additional <tt>fileUrl</tt> property whose value a dereferenceable IRI that can be used to retrieve the file; and an additional <tt>mimeType</tt> property whose value is the MIME type of the file described by the object.</td>
  </tr>
  <tr>
    <td><tt>game</tt></td>
    <td>Represents a game or competition of any kind.</td>
  </tr>
  <tr>
    <td><tt>group</tt></td>
    <td>Represents a grouping of objects in which member objects can join or leave. Objects of this type MAY contain the additional properties specified <a href='#roleGroup'>here</a>.</td>
  </tr>
  <tr>
    <td><tt>image</tt></td>
    <td>Represents a graphical image. Objects of this type MAY contain an additional <tt>fullImage</tt> property whose value is an Activity Streams Media Link to a "full-sized" representation of the image.</td>
  </tr>
  <tr>
    <td><tt>issue</tt></td>
    <td>Represents a report about a problem or situation that needs to be resolved. For instance, the <tt>issue</tt> object can be used to represent reports detailing software defects, or reports of acceptable use violations, and so forth. Objects of this type MAY contain the additional properties specified <a href='#issue'>here</a>.</td>
  </tr>
  <tr>
    <td><tt>job</tt></td>
    <td>Represents information about a job or a job posting.</td>
  </tr>
  <tr>
    <td><tt>note</tt></td>
    <td>Represents a short-form text message. This object is intended primarily for use in "micro-blogging" scenarios and in systems where users are invited to publish short, often plain-text messages whose useful lifespan is generally shorter than that of an article of weblog entry. A note is similar in structure to an article, but typically does not have a title or distinct paragraphs and tends to be much shorter in length.</td>
  </tr>
  <tr>
    <td><tt>offer</tt></td>
    <td>Represents an offer of any kind.</td>
  </tr>
  <tr>
    <td><tt>organization</tt></td>
    <td>Represents an organization of any kind.</td>
  </tr>
  <tr>
    <td><tt>page</tt></td>
    <td>Represents an area, typically a web page, that is representative of, and generally managed by a particular entity. Such areas are usually dedicated to displaying descriptive information about the entity and showcasing recent content such as articles, photographs and videos. Most social networking applications, for example, provide individual users with their own dedicated "profile" pages. Several allow similar types of pages to be created for commercial entities, organizations or events. While the specific details of how pages are implemented, their characteristics and use may vary, the one unifying property is that they are typically "owned" by a single entity that is represented by the content provided by the page itself.</td>
  </tr>
  <tr>
    <td><tt>permission</tt></td>
    <td>Represents a permission that can be granted to an individual. For instance, a person can be granted permission to modify a file.  Objects of this type MAY contain the additional properties specified <a href='#permissions'>here</a>.
  </tr>
  <tr>
    <td><tt>person</tt></td>
    <td>Represents an individual person.</td>
  </tr>
  <tr>
    <td><tt>place</tt></td>
    <td>Represents a physical location. Locations can be represented using geographic coordinates, a physical address, a free-form location name, or any combination of these. Objects of this type MAY contain the additional properties specified <a href='#place'>here</a>.</td>
  </tr>
  <tr>
    <td><tt>process</tt></td>
    <td>Represents any form of process. For instance, a long-running task that is started and expected to continue operating for a period of time.</td>
  </tr>
  <tr>
    <td><tt>product</tt></td>
    <td>Represents a commercial good or service. Objects of this type MAY contain an additional <tt>fullImage</tt> property whose value is an Activity Streams Media Link to an image resource representative of the product.</td>
  </tr>
  <tr>
    <td><tt>question</tt></td>
    <td>Represents a question or a poll. Objects of this type MAY contain an additional <tt>options</tt> property whose value is an Array of possible answers to the question in the form of Activity Stream objects of any type.</td>
  </tr>
  <tr>
    <td><tt>review</tt></td>
    <td>Represents a primarily prose-based commentary on another object. Objects of this type MAY contain a <tt>rating</tt> property as specified <a href='#rating-property'>here</a>.</td>
  </tr>
  <tr>
    <td><tt>role</tt></td>
    <td>Represents a role assigned to some entity within a specific context. For instance, a person be assigned the "admin" role within a particular group. Objects of this type MAY contain the additional properties specified <a href='#roleGroup'>here</a>.</td>
  </tr>
  <tr>
    <td><tt>service</tt></td>
    <td>Represents any form of hosted or consumable service that performs some kind of work or benefit for other entities. Examples of such objects include websites, businesses, etc.</td>
  </tr>
  <tr>
    <td><tt>task</tt></td>
    <td>Represents an activity that has yet to be completed. Objects of this type can contain additional properties as specified <a href='#task'>here</a>.</td>
  </tr>
  <tr>
    <td><tt>team</tt></td>
    <td>Represents a team of any type.</td>
  </tr>
  <tr>
    <td><tt>video</tt></td>
    <td>Represents video content of any kind. Objects of this type MAY contain additional properties as specified <a href='#audio-video'>here</a>.</td>
  </tr>
</table>

### Audio and Video Objects
<a name="audio-video" />
In addition to the core properties shared by all Activity Streams Objects, <tt>audio</tt> and <tt>video</tt> objects MAY contain the following properties:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>embedCode</tt></td>
    <td>String</td>
    <td>A fragment of HTML markup that, when embedded within another HTML page, provides an interactive user-interface for viewing or listening to the video or audio stream.</td>
  </tr>
  <tr>
    <td><tt>stream</tt></td>
    <td>Media Link</td>
    <td>An Activity Streams Media Link to the video or audio content itself.
  </tr>
</table>

For example:

``` json
  {
    "objectType": "video",
    "displayName": "Cute little kittens",
    "embedCode": "<video width="320" height="240" controls="controls">...</video>",
    "stream": {
      "url": "http://example.org/my_video.mpg"
    }
  }
```

### Binary Objects
<a name="binary" />
The <tt>binary</tt> object type is used to carry arbitrary Base64-encoded binary data within an Activity Stream object.  It is primarily intended to attach binary data to other object types through the use of the <tt>attachments</tt> property.

In addition to the core properties shared by all Activity Streams Objects, <tt>binary</tt> objects MAY contain the following properties:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>compression</tt></td>
    <td>String</td>
    <td>An optional token identifying a compression algorithm applied to the binary data prior to Base64-encoding.  Possible algorithms are "deflate" and "gzip", respectively indicating the use of the compression mechanisms defined by RFC 1951 and RFC 1952.  Additional compression algorithms MAY be used but are not defined by this specification.  Note that previous versions of this specification allowed for multiple compression algorithms to be applied and listed using a comma-separated format.  The use of multiple compressions is no longer permitted.</td>
  </tr>
  <tr>
    <td><tt>data</tt></td>
    <td>String</td>
    <td>The URL-Safe Base64-encoded representation of the binary data</td>
  </tr>
  <tr>
    <td><tt>fileUrl</tt></td>
    <td>String</td>
    <td>An optional IRI for the binary data described by this object.</td>
  </tr>
  <tr>
    <td><tt>length</tt></td>
    <td>Non-negative Integer</td>
    <td>The total number of unencoded, uncompressed octets contained within the "data" field.</td>
  </tr>
  <tr>
    <td><tt>md5</tt></td>
    <td>String</td>
    <td>An optional MD5 checksum calculated over the unencoded, uncompressed octets contained within the "data" field</td>
  </tr>
  <tr>
    <td><tt>mimeType</tt></td>
    <td>String</td>
    <td>The MIME Media Type of the binary data contained within the object.</td>
  </tr>
</table>

Note that the <tt>binary</tt> and <tt>file</tt> objectTypes are conceptually related.  The key difference between the two lies in the fact that the "file" objectType is more representative of the abstract description of a file or document while the <tt>binary</tt> objectType represents the actual, concrete stream of octets that make up the content.

Because of their close relationship, it is possible for the <tt>file</tt> objectType to share the same basic properties as the <tt>binary</tt> objectType.  That is, a <tt>file</tt> MAY also have properties such as <tt>length</tt>, <tt>mimeType</tt>, and <tt>md5</tt>.

For example
``` json
  {
    "objectType": "note",
    "displayName": "A note with a binary attachment",
    "attachments": [
      {
        "objectType": "binary",
        "data": "dGhpcyBpcyB1bmNvbXByZXNzZWQgZGF0YQo=",
        "md5": "827ae7e1ab45e4dd591d087c741e5770",
        "length": 25
      }
    ]
  }
```

###  Event
<a name="event" />
In addition to the core properties shared by all Activity Streams Objects, <tt>event</tt> objects MAY contain the following properties:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>attendedBy</tt></td>
    <td>Collection</td>
    <td>A collection object as defined in Section 3.5 of the JSON Activity Streams specification that provides information about entities that attended the event.</td>
  </tr>
  <tr>
    <td><tt>attending</tt></td>
    <td>Collection</td>
    <td>A collection object as defined in Section 3.5 of the JSON Activity Streams specification that provides information about entities that intend to attend the event.</td>
  </tr>
  <tr>
    <td><tt>endTime</tt></td>
    <td>String</td>
    <td>The date and time that the event ends represented as a String conforming to the "date-time" production in [RFC3339].</td>
  </tr>
  <tr>
    <td><tt>invited</tt></td>
    <td>Collection</td>
    <td>A collection object as defined in Section 3.5 of the JSON Activity Streams specification that provides information about entities that have been invited to the event.</td>
  </tr>
  <tr>
    <td><tt>maybeAttending</tt></td>
    <td>Collection</td>
    <td>A collection object as defined in Section 3.5 of the JSON Activity Streams specification that provides information about entities that possibly may attend the event.</td>
  </tr>
  <tr>
    <td><tt>notAttendedBy</tt></td>
    <td>Collection</td>
    <td>A collection object as defined in Section 3.5 of the JSON Activity Streams specification that provides information about entities that did not attend the event.</td>
  </tr>
  <tr>
    <td><tt>notAttending</tt></td>
    <td>Collection</td>
    <td>A collection object as defined in Section 3.5 of the JSON Activity Streams specification that provides information about entities that do not intend to attend the event.</td>
  </tr>
  <tr>
    <td><tt>startTime</tt></td>
    <td>String</td>
    <td>The date and time that the event begins represented as a String confirming to the "date-time" production in RFC 3339.</td>
  </tr>
</table>

For example:
``` json
  {
    "objectType": "event",
    "displayName": "Meeting with Joe",
    "startTime": "2012-12-12T12:00:00Z",
    "endTime: "2012-12-12T13:00:00Z",
    "invited": {
      "items": [
        {"objectType": "person", 
         "displayName": "Joe"}
      ]
    },
    "attending": {
      "items": [
        {"objectType": "person", 
         "displayName": "Joe"}
      ]
    }
  }
```

### Issue
<a name="issue" />
In addition to the core properties shared by all Activity Streams Objects, <tt>issue</tt> objects MAY contain the following properties:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>types</tt><td>
    <td>Array</td> 
    <td> An array of one or more absolute IRI's that describe the type of issue represented by the object. Note that the IRI's are intended for use as identifiers and MAY or MAY NOT be dereferenceable.</td>
  </tr>
</table>

For example:
``` json
  {
    "objectType": "issue",
    "displayName": "Terms of Use Violation",
    "url": "http://.../terms-of-use",
    "types": [
      "http://example.org/codes/inappropriateMaterial",
      "http://example.org/codes/copyrightViolation"
    ]
  }
```

### Permission
<a name="permissions">
In addition to the core properties shared by all Activity Streams Objects, <tt>permission</tt> objects MAY contain the following properties:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>scope</tt></td>
    <td>Activity Streams Object</td> 
    <td>A single Activity Streams Object, of any objectType, that identifies the scope of the permission. For example, if the permission objects describes write permissions for a given file, the <tt>scope</tt> property would be a <tt>file</tt> object describing that file.</td>
  </tr>
  <tr>
    <td><tt>actions</tt></td>
    <td>Array of Strings</td>
    <td>An array of Strings that identify the specific actions associated with the permission. The actions are application and scope specific. No common, core set of actions is defined by this specification.</td>
  </tr>
</table>

For example:
``` json
  {
    "objectType": "permission",
    "displayName": "Permission to Edit File: 2Q2014 Sales Forecast.xls",
    "scope": {
      "objectType": "file",
      "displayName": "2Q2014 Sales Forecast.xls"
    },
    "actions": ["modify", "delete", "create"]
  }
```

### Place
<a name="place" />
In addition to the core properties shared by all Activity Streams Objects, <tt>place</tt> objects MAY contain the following properties:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>position</tt></td>
    <td>JSON Object</td>
    <td>The latitude, longitude and altitude of the place as a point on Earth. Represented as a JSON Object as described below.</td>
  </tr>
  <tr>
    <td><tt>address</tt></td>
    <td>JSON Object</td>
    <td>A physical address represented as a JSON object as described below.</td>
  </tr>
</table>

The properties for the <tt>position</tt> property are:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>altitude</tt></td>
    <td>Floating point Number</td>
    <td>The elevation of this point relative to the Earth, in meters above or below mean sea level (e.g. 8848.00, -86.00).</td>
  </tr>
  <tr>
    <td><tt>latitude</tt></td>
    <td>Floating point Number</td>
    <td>The latitude of this point on Earth according to the WGS-84 coordinate reference system in decimal degrees (e.g. 27.9881, -3.12676).</td>
  </tr>
  <tr>
    <td><tt>longitude</tt></td>
    <td>Floating point Number</td>
    <td>The longitude of this point on Earth according to the WGS-74 coordinate reference system in decimal degrees (e.g. 86.9253, -134.4323).</td>
  </tr>
</table>

For example:
``` json
  {
    "objectType": "place",
    "displayName": "Some Random Location on Earth",
    "position": {
      "latitude": 34.34,
      "longitude": -127.23,
      "altitude": 100.05
    }
  }
```

Note that in older versions of this specification, the value of the <tt>position</tt> property was represented as an ISO 6709 compliant String. For instance <tt>"position":"+27.5916+086.5640+8850/"</tt>.  This format has been deprecated and SHOULD NOT be used.  However, there might be existing deployed applications still utilizing the ISO 6709. Consuming implementations can choose to continue supporting the ISO 6709 format but SHOULD NOT produce Activity Streams that use the deprecated format.

The properties for the <tt>address</tt> property are:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>formatted</tt></td>
    <td>String</td>
    <td>The full mailing address formatted for display or use with a printed mailing label.</td>
  </tr>
  <tr>
    <td><tt>streetAddress</tt></td>
    <td>String</td>
    <td>The street address including house number, street name, P.O. Box, apartment or unit number and extended multi-line address information.</td>
  </tr>
  <tr>
    <td><tt>locality</tt></td>
    <td>String</td>
    <td>The city or locality</td>
  </tr>
  <tr>
    <td><tt>region</tt></td>
    <td>String</td>
    <td>The state or region</td>
  </tr>
  <tr>
    <td><tt>postalCode</tt></td>
    <td>String</td>
    <td>The zip or postal code</td>
  </tr>
  <tr>
    <td><tt>country</tt></td>
    <td>String</td>
    <td>The country name component</td>
  </tr>
</table>

For example:
``` json
  {
    "objectType": "place",
    "displayName": "This is not really my address",
    "address": {
      "formatted": "111 North First Street, New York, NY 11111",
      "streetAdress": "111 North First Street",
      "locality": "New York",
      "region": "NY",
      "postalCode": "11111",
      "country": "US"
    }
  }
```

### Roles and Groups
<a name="roleGroup">
In addition to the core properties shared by all Activity Streams Objets, <tt>role</tt> and <tt>group</tt> objects MAY contain the following:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>members</tt></td>
    <td>Collection Object</td>
    <td>An optional Activity Streams Collection object listing the members of a group, or listing the entities assigned to a particular role.</td>
</table> 

For example:
``` json
  {
    "objectType": "group",
    "displayName": "My Work Group",
    "members": {
      "items": [
        {
          "objectType": "person",
          "displayName": "Laura"
        },
        {
          "objectType": "person",
          "displayName": "Mark"
        }
      ]
    }
  }
```

### Task
<a name="task" />
In addition to the core properties shared by all Activity Streams Objects, <tt>task</tt> objects MAY contain the following properties:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>actor</tt></td>
    <td>Activity Streams Object</td>
    <td>An Activity Streams Object that provides information about the actor that is expected to complete the task.</td>
  </tr>
  <tr>
    <td><tt>by</tt></td>
    <td>String</td>
    <td>A RFC 3339 <tt>date-time</tt> specifying the date and time by which the task is to be completed.</td>
  </tr>
  <tr>
    <td><tt>object</tt></td>
    <td>Activity Streams Object</td>
    <td>An Activity Streams object describing the object of the task.</td>
  </tr>
  <tr>
    <td><tt>prerequisites</tt></td>
    <td>Array of Task Objects</td>
    <td>An Array of other Task objects that are to be completed before this task can be completed.</td>
  </tr>
  <tr>
    <td><tt>required</tt></td>
    <td>Boolean</td>
    <td>A boolean value indicating whether completion of this task is considered to be mandatory.</td>
  </tr>
  <tr>
    <td><tt>supersedes</tt></td>
    <td>Array of Task Objects</td>
    <td>An Array of other Task objects that are superseded by this task object.</td>
  </tr>
  <tr>
    <td><tt>verb</tt></td>
    <td>String</td>
    <td>A string indicating the verb for this task as defined in Section 3.2 of [activitystreams].</td>
  </tr>
</table>

For example:
``` json
  {
    "objectType": "task",
    "displayName": "James needs to read the spec",
    "by": "2012-12-12T12:12:12Z",
    "verb": "read",
    "actor": {
      "objectType": "person",
      "displayName": "James"
    },
    "object": {
      "objectType": "file",
      "displayName": "A specification",
      "url": "http://example.org/spec.html"
    },
    "required": true
  }
```

## Base Extension Properties
<a name="extension" />
This specification defines an initial set of extension properties that can be used with all activities or objects.

###  Context
<a name="context" />
The basic model for an Activity provides properties that allow the expression of who (<tt>actor</tt>) performed the action, what (<tt>object</tt>) was acted upon, the action (<tt>verb</tt>) that was taken, and to what the action was directed (<tt>target</tt>).  The additional <tt>context</tt> property allows the Activity to further include information about why a particular action occurred by providing details about the context within which a particular Activity was performed.  The value of the <tt>context</tt> property is an Object of any objectType.  The meaning of the <tt>context</tt> property is only defined when used within an Activity object.

For example, the following Activity uses the <tt>context</tt> property to reference the specific reasons a particular article object has been flagged as being inappropriate:
``` json
  {
    "actor": {
      "objectType": "person",
      "displayName": "Joe"
    },
    "verb": "flag-as-inappropriate",
    "object": {
      "objectType": "article",
      "displayName": "An article about stuff"
    },
    "context": {
      "objectType": "issue",
      "displayName": "Terms of Use Violation",
      "url": "http://.../terms-of-use",
      "types": [
        "http://example.org/codes/inappropriateMaterial",
        "http://example.org/codes/copyrightViolation"
      ]
    }
  }
```

### Location
<a name="location" />
Location data can be added to any object type or activity.  Location can be specified via geographic coordinates, a street address, a free-form location name or any combination of these.

Within a JSON-serialized Activity Stream, the Location is represented using a property named <tt>location</tt> whose value is a [Place](#place) object.  The objectType property of this object MAY be omitted.

When appearing within an activity, the location data indicates the location where the activity occurred.  When appearing within an object, the location data indicates the location of that object at the time the activity occurred.

For example:
``` json
  {
    "objectType": "person",
    "displayName": "John Doe",
    "location": {
      "displayName": "Mount Everest",
      "position": {
        "altitude": 8848.00,
        "latitude": 27.9881,
        "longitude": 86.9253
      }
    }
  }
```

### Mood
<a name="mood-property" />
Mood describes the mood of the user when the activity was performed. This is usually collected via an extra field in the user interface used to perform the activity.  For the purpose of this schema, a mood is a freeform, short mood keyword or phrase along with an optional mood icon image.

In JSON, Moods are included within an object or activity using a property named <tt>mood</tt> whose value is a JSON object with the following properties:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>displayName</tt></td>
    <td>String</td>
    <td>The natural-language, human-readable and plain-text keyword or phrase describing the mood. HTML markup MUST NOT be included.</td>
  </tr>
  <tr>
    <td><tt>image</tt></td>
    <td>Media Link</td>
    <td>An optional image that provides a visual representation of the mood.</td>
  </tr>
</table>

For example:
``` json
  {
    "objectType": "person",
    "displayName": "James",
    "mood": {
      "displayName": "happy",
      "image": {
        "url": "http://example.org/emot/happy.png"
      }
    }
  }
```
   
### Rating
<a name="rating-property" />
A rating given as a number between 1.0 and 5.0 inclusive with one decimal place of precision.  Represented in JSON as a property called <tt>rating</tt> whose value is a JSON number giving the rating.

Ratings are generally most useful only for particular types of objects, such as audio, video, photos and places.

For example:
``` json
  {
    "objectType": "review",
    "content": "This is a great product",
    "rating": 3.5
  }
```

### Result
<a name="result-property" />
The <tt>result</tt> provides a description of the result of any particular activity.  The value of the <tt>result</tt> property is an Object of any objectType.  The meaning of the <tt>result</tt> property is only defined when used within an Activity object.

For instance:
``` json
  {
    "actor": {
      "objectType": "person",
      "displayName": "Joe"
    },
    "verb": "complete",
    "object": {
      "objectType": "http://example.org/Exam",
      "displayName": "The Big Exam"
    },
    "result": {
      "score": 123,
      "duration": "P1H",
    }
  }
```

Use of the <tt>result</tt> property will generally only be applicable with certain combinations of verbs and objectTypes.  In many cases, the result will be implicit in the combination of actor, verb and object used -- for example, in an activity where a person, Joe, creates an article, the result of the activity is clear without the need to specify a separate <tt>result</tt> property.

### Source
<a name="source" />
The <tt>source</tt> property provides a reference to the original source of an object or activity.  The value of the <tt>source</tt> property is an Object of any objectType.

The <tt>source</tt> property is closely related to the <tt>generator</tt> and <tt>provider</tt> properties but serves the distinct purpose of identifying where the activity or object was originally published as opposed to identifying the applications that generated or published it.

For example:
``` json
  {
    "actor": {
      "objectType": "person",
      "displayName": "Joe"
    },
    "verb": "post",
    "object": {
      "objectType": "photo",
      "image": "http://example.org/photos/fluffycat.jpg"
    },
    "source": {
      "objectType": "collection",
      "displayName": "Joe's Photo's",
      "url": "http://example.org/joes/photos"
    }
  }
```

### Starting and Ending Timestamps
<a name="startEndTime" />
When an long running Activity occurs over a distinct period of time, or when an Object represents a long-running process or event, the <tt>startTime</tt> and <tt>endTime</tt> properties can be used to specify the date and time at which the activity or object begins or concludes.  The values for each are represented as JSON Strings conforming to the "date-time" production in [RFC3339][RFC3339].

For example:
``` json
  {
    "actor": {
      "objectType": "person",
      "displayName": "John Doe"},
    "verb": "at",
    "object": {
      "objectType":"place",
      "displayName":"Home"},
    "published": "2012-08-28T03:34:23Z",
    "startTime": "2012-08-12T12:13:14Z",
    "endTime": "2012-08-13T01:34:12Z"
  }
```

The <tt>startTime</tt> and <tt>endTime</tt> properties can be used independently or together.  If both are specified, the <tt>endTime</tt> property MUST specify a moment in time that is more recent that that specified by the <tt>startTime</tt> property.

### Tags
<a name="tags" />
A listing of the objects that have been associated with a particular object.  Represented in JSON using a property named <tt>tags</tt> whose value is an Array of objects.

For example:
``` json
  {
    "objectType": "photo",
    "image": "http://example.org/photos/fluffycat.jpg",
    "tags": [
      {
        "objectType": "person",
        "displayName": "John"
      },
      {
        "objectType": "person",
        "displayName": "Jane"
      }
    ]
  }
```

### Multi-page Collections
<a name="multipage-collections" />
A multi-page collection is a set of linked collection objects that together contain the complete set of objects that can be considered to be members of the collection.

When using multi-paged collections, the following additional properties can be used in addition to the core collection properties defined in section 3.5 of [activitystreams][activitystreams].

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>itemsAfter</tt></td>
    <td>String</td>
    <td>An RFC 3339 date-time, as described in Section 3 of [activitystreams], indicating that the <tt>items</tt> array contains only items published or updated after the date and time specified.</td>
  </tr>
  <tr>
    <td><tt>itemsBefore</tt></td>
    <td>String</td>
    <td>An RFC 3339 date-time, as described in Section 3 of [activitystreams], indicating that the <tt>items</tt> array contains only items published or updated before the date and time specified.</td>
  </tr>
  <tr>
    <td><tt>itemsPerPage</tt></td>
    <td>Non-negative Integer</td>
    <td>A non-negative integer specifying the maximum number of objects that will be included in the value of the <tt>items</tt> array.</td>
  </tr>
  <tr>
    <td><tt>links</tt></td>
    <td>Links Object</td>
    <td>Collection of links connecting this collection object to other collection objects containing additional items that can be considered to be members of the same logical set.</td>
  </tr>
  <tr>
    <td><tt>startInde</tt></td>
    <td>Non-negative Integer</td>
    <td>A non-negative integer value identifying the relative position within the collection of the first object contained in the items property.  For instance, if there are 20 items that are considered to be members of a collection, but only the last 10 of those items are serialized within the value of the "items" property, the value of "startIndex" would be 10.</td>
  </tr>
</table>      
   
The value of the <tt>[links](#links)</tt> property is an object.  The members of the object are Registered or Extension Link Relations as defined by [RFC5988][RFC5988].  The following Registered Link Relations are identified as having specific purpose for use with Multi-page Collections:

<table border="1">
  <tr><th align="left">Name</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>first</tt></td>
    <td>Link Object</td>
    <td>A Link Object referencing the further preceding page of the multi-page collection.</td>
  </tr>
  <tr>
    <td><tt>last</tt></td>
    <td>Link Object</td>
    <td>A Link Object referencing the further following page of the multi-page collection.</td>
  </tr>
  <tr>
    <td><tt>prev</tt></td>
    <td>Link Object</td>
    <td>A Link Object referencing the immediately preceding page of the multi-page collection. Note that "previous" can be used an an equivalent alternative; however implementations SHOULD use "prev" and MUST NOT used both "prev" and "previous" within the same "links" object.</td>
  </tr>
  <tr>
    <td><tt>next</tt></td>
    <td>Link Object</td>
    <td>A Link Object referencing the immediately following page of the multi-page collection.</td>
  </tr>
  <tr>
    <td><tt>current</tt></td>
    <td>Link Object</td>
    <td>A Link Object referencing the page containing the items have been updated or published most recently.</td>
  </tr>
  <tr>
    <td><tt>self</tt></td>
    <td>Link Object</td>
    <td>A Link Object referencing this page.</td>
  </tr>    
</table>

For example, one page of a multi-page collection:
``` json
  {
    "totalItems": 12,
    "itemsPerPage" : 10,
    "startIndex": 10,
    "links": {
      "self": {"href":"http://example.org/items?page=1"},
      "next": {"href":"http://example.org/items?page=2"},
      "prev": {"href":"http://example.org/items?page=3"},
      "current": {"href":"http://example.org/items"}
    },
    "items" : [
      {
        "objectType": "person",
        "displayName":"Joe"
      },
      {
        "objectType": "person",
        "displayName":"Sally"
      }
    ]
  }
```

Note that, as the example illustrates, the <tt>totalItems</tt> property specifies the total number of items that can be considered to be a part of the collection as a whole, while the <tt>itemsPerPage</tt> indicates the maximum number of objects that will be included in this particular subset.  The actual number of objects included in the value of the <tt>items</tt> property can be equal to or less than either of these values.

##  External Vocabularies
<a name="external-vocabularies" />
Any object within an Activity Streams object can be extended with additional properties not defined by the core Activity Streams [activitystreams][activitystreams] specification or this document.  Such extension properties can be specific to individual applications or be drawn from other defined vocabularies such as that defined by the Schema.org organization and others.

When utilizing such vocabularies, it is possible that conflicts in the naming of properties and format of expected values might arise. To mitigate the risk of such conflicts, the following guidelines SHOULD be followed:

1. When selecting the <tt>objectType</tt> for an object, if there is a close equivalent <tt>objectType</tt> already defined by thisspecification, then that <tt>objectType</tt> SHOULD be used.
2. When properties specific to an external vocabulary are to be included within an object, those SHOULD be grouped together under a single namespace property whose name is uniquely reflective of the vocabulary.
3. When including properties from the external vocabulary, avoid properties that are a close semantic match to existing properties defined by this or the core Activity Streams [activitystreams][activitystreams] specification.  For example, within the Schema.org vocabulary, the properties <tt>name</tt>, <tt>description</tt>, <tt>url</tt> and <tt>image</tt> are semantically equivalent to core Activity Streams object properties and therefore SHOULD NOT be used.
4. Further, avoid utilizing properties from multiple external vocabularies that are similar or semantically equivalent to each other.

This specification defines the following initial set of namespace properties that correspond to specific external vocabularies currently considered to be reasonable candidates for use within Activity Streams objects.  Future versions of this specification might add additional namespace properties to this list. Implementors are free to define additional namespace properties representing other external vocabularies as necessary; however, there is a risk of potential conflicts if multiple independent implementors select the same namespace property to represent different external vocabularies.  To help prevent such conflicts, it is RECOMMENDED that implementors publicly document their use of external vocabularies.

### "dc"
<a name="dc" />
The <tt>dc</tt> namespace property is defined to encapsulate the set of extension properties that represent information specific to the [Dublin Core Metadata Initiative][1].  If, for instance, Dublin Core properties can be applied to an Activity Streams object, those properties SHOULD be grouped together under the <tt>dc</tt> property.

For example:
``` json json
  {
    "objectType": "file",
    "displayName": "A Document",
    "fileUrl": "http://example.org/foo.html"
    "dc": {
      "format": "text/html; charset="UTF-8"
    }
  }
```
  
### "geojson"
<a name="geojson" />
The <tt>geojson</tt> namespace property is defined defined to encapsulate the set of extension properties that represent information specific to an [GeoJSON][2] data type.  If, for instance, GeoJSON properties can be applied to an Activity Streams object, those properties SHOULD be grouped together under the <tt>geojson</tt> property.

For example:
``` json
  {
    "objectType": "place",
    "displayName": "A GeoJSON Described Place",
    "geojson": {
      "type": "FeatureCollection",
      "features": [
        {"type": "Feature",
         "geometry": {
           "type": "Point",
           "coordinates": [102.0, 0.5]
         },
         "properties": {
           "prop0": "value0"}
        },
        {"type": "Feature",
         "geometry": {
           "type": "LineString",
           "coordinates": [
             [102.0, 0.0],
             [103.0, 1.0],
             [104.0, 0.0],
             [105.0, 1.0]
           ]
         },
         "properties": {
           "prop0": "value0",
           "prop1": 0.0}
        },
        {"type": "Feature",
         "geometry": {
           "type": "Polygon",
           "coordinates": [
             [[100.0, 0.0],
              [101.0, 0.0],
              [101.0, 1.0],
              [100.0, 1.0],
              [100.0, 0.0]]]
           },
           "properties": {
             "prop0": "value0",
             "prop1": {"this": "that"}
           }
        }
      ]
    }
  }
```

### "ld"
<a name="ld" />
The <tt>ld</tt> namespace property is defined to encapsulate the set of extension properties that represent information specific to the [JSON Linked Data][3] vocabulary.  If, for instance, Linked Data properties can be applied to an Activity Streams object, those properties SHOULD be grouped together under the <tt>ld</tt> property.

For example:
``` json json
  {
    "objectType": "person",
    "displayName": "John Doe",
    "ld": {
      "@context": "http://json-ld.org/contexts/person.ld",
      "@id": "http://example.org/john.doe",
      "born": "1929-12-12"
    }
  }
```

### "links"
<a name="links" />
The <tt>links</tt> namespace property is defined to encapsulate the set of extension properties that represent links to external resources. Property names are defined as being either Registered or Extension Link Relation Types as defined by [RFC5988][RFC5988].  The list of currently known Registered Link Relations can be found within the [IANA Registry of Link Relations][4].

For example:
``` json
  {
    "objectType": "note",
    "displayName": "This is a simple note",
    "links": {
      "canonical": {
  "href":"http://www.example.org/notes/123"
      },
      "edit": {
  "href":"http://www.example.org/api/notes/123"
      }
    }
  }
```

The value of each property within the <tt>links</tt> object is either a single [Link Object](#link-objects) or an array of Link Objects in the case where multiple links with the same Link Relation must be specified.

When the value is specified as an array of Link Objects, the ordering of values within the array is considered insignificant.  Each contained value is to be treated as a separate link.  An array SHOULD NOT contain multiple Link Objects specifying the same <tt>href</tt> value.

When using extension link relation types, the property name can be specified as an IRI [RFC3987][RFC3987] but MUST be converted to URIs [RFC3986][RFC3986] when compared and dereferenced as required by Section 4.2 of [RFC5988][RFC5988].

As defined in Section 3 of [RFC5988][RFC5988], such properties can be viewed as statements of the form "The containing object has a {relation type} resource at {target IRI}" where the {relation type} is identified by the property name, and the {target IRI} is provided by the property value.

### Link Objects
<a name="link-objects" />
All links are expressed as JSON objects that MUST contain an <tt>href</tt> property whose value is an absolute IRI [RFC3987][RFC3987] providing the target of the link.  The object MAY contain the following additional properties:

<table border="1">
  <tr><th align="left">Property</th><th align="left">Value</th><th align="left">Description</th></tr>
  <tr>
    <td><tt>hreflang</tt></td>
    <td>RFC4646 Language Tag</td>
    <td>A hint identifying the language of the target resource.</td>
  </tr>
  <tr>
    <td><tt>title</tt></td>
    <td>String</td>
    <td>A human-readable descriptive label for the link. HTML-markup SHOULD NOT be used.</td>
  </tr>
  <tr>
    <td><tt>type</tt></td>
    <td>String</td>
    <td>A hint identifying the MIME media type of the linked resource.</td>
  </tr>
</table>

Link Objects MAY contain an <tt>objectType</tt> property with the value <tt>link</tt>.

Additional properties MAY be specified but are undefined by this specification.

### "odata"
<a name="odata" />
The <tt>odata</tt> namespace property is defined to encapsulate the set of extension properties that represent information specific to the [OData][5] specification.  If, for instance, OData properties can be applied to an Activity Streams object, those properties SHOULD be grouped together under the <tt>odata</tt> property.

For example:
```  json
  {
    "objectType": "person",
    "displayName": "John Doe",
    "odata": {
      "__metadata": { ... },
      "com.example.user.kind" : "PAID",
      "CustomerID": "JDOE",
      "UserName": "jdoe",
    }
  }
``` 

### "opengraph"
<a name="opengraph" />
The <tt>opengraph</tt> namespace property is defined to encapsulate the set of extension properties that represent information specific to an [OpenGraph][6] data type.  If, for instance, OpenGraph properties can be applied to an Activity Streams object, those properties SHOULD be grouped together under the <tt>opengraph</tt> property.

For example:
```  json
  {
    "objectType": "person",
    "displayName": "John Smith",
    "opengraph": {
      "username": "john_smith",
      "verified": false,
      "relationship_status": "Single"
    }
  }
``` 

### "schema_org"
<a name="schema_org" />
The <tt>schema\_org</tt> namespace property is defined to encapsulate the set of extension properties that represent information specific to a [Schema.org][7] data type.  If, for instance, Schema.org properties can be applied to an Activity Streams object, those properties SHOULD be grouped together under the <tt>schema_org</tt> property.

For example:
```  json
  {
    "objectType": "person",
    "displayName": "John Smith",
    "schema_org": {
      "additionalType": ["http://schema.org/Person"]
      "birthDate": ["1976-12-23"],
      "gender": ["Male"]
    }
  }
```

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

