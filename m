Return-path: <prvs=316e2e0e9=Rasmus.Villemoes@prevas.dk>
Subject: Re: [PATCH v5 2/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
	Jonathan Corbet <corbet@lwn.net>
References: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1495462000-28979-3-git-send-email-rasmus.villemoes@prevas.dk>
 <d0da1701-5500-9cbb-eed1-5581e1a88b60@roeck-us.net>
CC: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	<esben.haabendal@gmail.com>, <linux-watchdog@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <302570fe-6c4e-69fb-2e5a-7bad91edf45a@prevas.dk>
Date: Tue, 30 May 2017 10:00:42 +0200
MIME-Version: 1.0
In-Reply-To: <d0da1701-5500-9cbb-eed1-5581e1a88b60@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 2017-05-25 02:56, Guenter Roeck wrote:
> On 05/22/2017 07:06 AM, Rasmus Villemoes wrote:
>> diff --git a/Documentation/watchdog/watchdog-parameters.txt
>> b/Documentation/watchdog/watchdog-parameters.txt
>> index 914518a..4801ec6 100644
>> --- a/Documentation/watchdog/watchdog-parameters.txt
>> +++ b/Documentation/watchdog/watchdog-parameters.txt
>> @@ -8,6 +8,15 @@ See Documentation/admin-guide/kernel-parameters.rst
>> for information on
>>   providing kernel parameters for builtin drivers versus loadable
>>   modules.
>>   +The watchdog core currently understands one parameter,
> 
> We have a second parameter queued, handle_boot_enabled. Please rephrase
> so we don't have to change the text with each new parameter.

I agree that it makes sense to rephrase to avoid having to edit when
other parameters are added, and I'll send v6 in a moment. But regarding
the handle_boot_enabled, I think my patch set implements a superset of
that functionality (just set watchdog.open_timeout to 1ms), which is why
I asked Sebastian specifically to look at the patches, and he said that
they'd work for his use case as well. So while I personally don't really
care if both go in, it does seem a little silly and somewhat confusing
to have two parameters to do more-or-less the same thing.

Btw, where can I find the watchdog-next tree (or whatever it's called)
to see what is queued up?

-- 
Rasmus Villemoes
Software Developer
Prevas A/S
Hedeager 1
DK-8200 Aarhus N
+45 51210274
rasmus.villemoes@prevas.dk
www.prevas.dk
