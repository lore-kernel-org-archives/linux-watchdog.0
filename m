Return-path: <linux@rasmusvillemoes.dk>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCHv2] watchdog: core: add option to avoid early handling of watchdog
References: <f38c7967-ac56-c188-2232-42544088edd8@roeck-us.net>
	<20170512120532.12986-1-sebastian.reichel@collabora.co.uk>
	<4a4c4de8-31e4-8e15-8c63-ebd4165a63bf@roeck-us.net>
Date: Tue, 16 May 2017 00:08:32 +0200
In-Reply-To: <4a4c4de8-31e4-8e15-8c63-ebd4165a63bf@roeck-us.net> (Guenter
	Roeck's message of "Sun, 14 May 2017 07:47:13 -0700")
Message-ID: <878tlxpycf.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, May 14 2017, Guenter Roeck wrote:

> On 05/12/2017 05:05 AM, Sebastian Reichel wrote:
>> On some systems its desirable to have watchdog reboot the system
>> when it does not come up fast enough. This adds a kernel parameter
>> to disable the auto-update of watchdog before userspace takes over
>> and a kernel option to set the default. The info messages were
>> added to shorten error searching on misconfigured systems.
>>
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>
> Minor nitpicks below (which I fixed up in my watchdog-next branch).
> Otherwise

Guenter, Sebastian, can I pursuade you to take a (second) look at the
patches [1] I sent 4 months ago that implement the same thing, except
that they also give a .config and a boot-cmdline way to define what
"fast enough" means - which is necessary in many cases where it's simply
not realistic to have userspace up-and-running before the dog is hungry.

[1] https://lkml.org/lkml/2017/1/9/408

I'm of course happy to rebase and retest those on top of current master,
but the implementation and semantics should be reviewable as-is.

Rasmus
