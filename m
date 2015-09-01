Return-path: <justinpopo6@gmail.com>
MIME-Version: 1.0
In-Reply-To: <55E1811A.9000709@roeck-us.net>
References: <1440799086-14683-1-git-send-email-justinpopo6@gmail.com>
	<55E1811A.9000709@roeck-us.net>
Date: Tue, 1 Sep 2015 10:20:36 -0700
Message-ID: <CAJx26kVz2Sem6PSBgKnQoa+1zo1frsmhx8a7eJBC8v+WY=gpvA@mail.gmail.com>
Subject: Re: [PATCH] watchdog_dev: Use device tree alias for naming watchdogs
From: Justin Chen <justinpopo6@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: multipart/alternative; boundary=001a11414536aab92b051eb2c47b
List-ID: <linux-watchdog@vger.kernel.org>

--001a11414536aab92b051eb2c47b
Content-Type: text/plain; charset=UTF-8

On Sat, Aug 29, 2015 at 2:53 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 08/28/2015 02:58 PM, Justin Chen wrote:
>>
>> Currently there is no way to easily differentiate multiple
>> watchdog devices. The watchdogs are named by the order they
>> are probed.
>> 1st probed watchdog: /dev/watchdog0
>> 2nd probed watchdog: /dev/watchdog1
>> ...
>>
>> This change uses the alias of the watchdog device node for
>> the name of the watchdog.
>> aliases {
>>         watchdog0 = "/...../...."
>>         watchdog3 = "/..../....."
>>         watchdog2 = "/..../....."
>>         ...
>> }
>>
>> This will translate to...
>> /dev/watchdog0
>> /dev/watchdog3
>> /dev/watchdog2
>>
>> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
>
>
> Interesting idea. Checking through other subsystems, many others do the
> same,
> so it makes sense to use that mechanism.
>
> However, the id assignment should be in the calling code, in
> __watchdog_register_device,
> to avoid that another id, possibly conflicting, is assigned through the
ida
> mechanism.
>
> This is a bit more complicated than it looks like to ensure correct id
> assignment.
> Have a look into the i2c code to see how it is handled. Essentially we
must
> pass
> the requested number to ida_simple_get().
>
> Thanks,
> Guenter

Ok that makes sense. I will put a wrapper function around ida_simple_get()
that will request a specific number, if that fails then do a normal request.
Something like this...

ret = of_alias_get_id(....)

id = ida_simple_get(&watchdog_ida, ret, ret, GFP_KERNEL);

if (id != ret)
    id = ida_simple_get(&watchdog_ida, 0, MAX_DOGS, GFP_KENREL);

thanks,
Justin


>
>
>> ---
>>   drivers/watchdog/watchdog_dev.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/watchdog_dev.c
>> b/drivers/watchdog/watchdog_dev.c
>> index 6aaefba..52b1f0b 100644
>> --- a/drivers/watchdog/watchdog_dev.c
>> +++ b/drivers/watchdog/watchdog_dev.c
>> @@ -41,6 +41,7 @@
>>   #include <linux/miscdevice.h> /* For handling misc devices */
>>   #include <linux/init.h>               /* For __init/__exit/... */
>>   #include <linux/uaccess.h>    /* For copy_to_user/put_user/... */
>> +#include <linux/of.h>
>>
>>   #include "watchdog_core.h"
>>
>> @@ -522,7 +523,13 @@ static struct miscdevice watchdog_miscdev = {
>>
>>   int watchdog_dev_register(struct watchdog_device *watchdog)
>>   {
>> -       int err, devno;
>> +       int err, devno, ret;
>> +
>> +       if (watchdog->parent) {
>> +               ret = of_alias_get_id(watchdog->parent->of_node,
>> "watchdog");
>> +               if (ret >= 0)
>> +                       watchdog->id = ret;
>> +       }
>>
>>         if (watchdog->id == 0) {
>>                 old_wdd = watchdog;
>>
>

--001a11414536aab92b051eb2c47b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Aug 29, 2015 at 2:53 AM, Guenter Roeck &lt=
;<a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a>&gt; wrote:<br=
>&gt; On 08/28/2015 02:58 PM, Justin Chen wrote:<br>&gt;&gt;<br>&gt;&gt; Cu=
rrently there is no way to easily differentiate multiple<br>&gt;&gt; watchd=
og devices. The watchdogs are named by the order they<br>&gt;&gt; are probe=
d.<br>&gt;&gt; 1st probed watchdog: /dev/watchdog0<br>&gt;&gt; 2nd probed w=
atchdog: /dev/watchdog1<br>&gt;&gt; ...<br>&gt;&gt;<br>&gt;&gt; This change=
 uses the alias of the watchdog device node for<br>&gt;&gt; the name of the=
 watchdog.<br>&gt;&gt; aliases {<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 wa=
tchdog0 =3D &quot;/...../....&quot;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 watchdog3 =3D &quot;/..../.....&quot;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 watchdog2 =3D &quot;/..../.....&quot;<br>&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ...<br>&gt;&gt; }<br>&gt;&gt;<br>&gt;&gt; This will translate to...<=
br>&gt;&gt; /dev/watchdog0<br>&gt;&gt; /dev/watchdog3<br>&gt;&gt; /dev/watc=
hdog2<br>&gt;&gt;<br>&gt;&gt; Signed-off-by: Justin Chen &lt;<a href=3D"mai=
lto:justinpopo6@gmail.com">justinpopo6@gmail.com</a>&gt;<br>&gt;<br>&gt;<br=
>&gt; Interesting idea. Checking through other subsystems, many others do t=
he<br>&gt; same,<br>&gt; so it makes sense to use that mechanism.<br>&gt;<b=
r>&gt; However, the id assignment should be in the calling code, in<br>&gt;=
 __watchdog_register_device,<br>&gt; to avoid that another id, possibly con=
flicting, is assigned through the ida<br>&gt; mechanism.<br>&gt;<br>&gt; Th=
is is a bit more complicated than it looks like to ensure correct id<br>&gt=
; assignment.<br>&gt; Have a look into the i2c code to see how it is handle=
d. Essentially we must<br>&gt; pass<br>&gt; the requested number to ida_sim=
ple_get().<br>&gt;<br>&gt; Thanks,<br>&gt; Guenter<br><br>Ok that makes sen=
se. I will put a wrapper function around ida_simple_get() that will request=
 a specific number, if that fails then do a normal request.<br>Something li=
ke this...<br><br>ret =3D of_alias_get_id(....)<br><br>id =3D ida_simple_ge=
t(&amp;watchdog_ida, ret, ret, GFP_KERNEL);<br><br>if (id !=3D ret)<br>=C2=
=A0=C2=A0=C2=A0 id =3D ida_simple_get(&amp;watchdog_ida, 0, MAX_DOGS, GFP_K=
ENREL);<br><br>thanks,<br>Justin<br><br><br>&gt;<br>&gt;<br>&gt;&gt; ---<br=
>&gt;&gt; =C2=A0 drivers/watchdog/watchdog_dev.c | 9 ++++++++-<br>&gt;&gt; =
=C2=A0 1 file changed, 8 insertions(+), 1 deletion(-)<br>&gt;&gt;<br>&gt;&g=
t; diff --git a/drivers/watchdog/watchdog_dev.c<br>&gt;&gt; b/drivers/watch=
dog/watchdog_dev.c<br>&gt;&gt; index 6aaefba..52b1f0b 100644<br>&gt;&gt; --=
- a/drivers/watchdog/watchdog_dev.c<br>&gt;&gt; +++ b/drivers/watchdog/watc=
hdog_dev.c<br>&gt;&gt; @@ -41,6 +41,7 @@<br>&gt;&gt; =C2=A0 #include &lt;li=
nux/miscdevice.h&gt; /* For handling misc devices */<br>&gt;&gt; =C2=A0 #in=
clude &lt;linux/init.h&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /* For __init/__exit/... */<br>&gt;&gt; =C2=A0 #include &lt;linux/uaccess.=
h&gt; =C2=A0 =C2=A0/* For copy_to_user/put_user/... */<br>&gt;&gt; +#includ=
e &lt;linux/of.h&gt;<br>&gt;&gt;<br>&gt;&gt; =C2=A0 #include &quot;watchdog=
_core.h&quot;<br>&gt;&gt;<br>&gt;&gt; @@ -522,7 +523,13 @@ static struct mi=
scdevice watchdog_miscdev =3D {<br>&gt;&gt;<br>&gt;&gt; =C2=A0 int watchdog=
_dev_register(struct watchdog_device *watchdog)<br>&gt;&gt; =C2=A0 {<br>&gt=
;&gt; - =C2=A0 =C2=A0 =C2=A0 int err, devno;<br>&gt;&gt; + =C2=A0 =C2=A0 =
=C2=A0 int err, devno, ret;<br>&gt;&gt; +<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=
=A0 if (watchdog-&gt;parent) {<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ret =3D of_alias_get_id(watchdog-&gt;parent-&gt;of_nod=
e,<br>&gt;&gt; &quot;watchdog&quot;);<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &gt;=3D 0)<br>&gt;&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 watchdog-&gt=
;id =3D ret;<br>&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 }<br>&gt;&gt;<br>&gt;&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (watchdog-&gt;id =3D=3D 0) {<br>&gt;&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 old_wdd =3D watchdog;<=
br>&gt;&gt;<br>&gt;<br><br></div>

--001a11414536aab92b051eb2c47b--
