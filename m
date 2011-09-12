Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6055 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618Ab1ILRyl (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Sep 2011 13:54:41 -0400
Message-ID: <4E6E471E.6060704@redhat.com>
Date: Mon, 12 Sep 2011 19:53:34 +0200
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: guenter.roeck@ericsson.com
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [PATCH 5/5] hwmon/sch5636: Add support for the integrated
 watchdog
References: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>  <1315821420-16205-6-git-send-email-hdegoede@redhat.com> <1315848826.2455.193.camel@groeck-laptop>
In-Reply-To: <1315848826.2455.193.camel@groeck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 09/12/2011 07:33 PM, Guenter Roeck wrote:
> On Mon, 2011-09-12 at 05:57 -0400, Hans de Goede wrote:
>> Add support for the watchdog integrated into the (Fujitsu Theseus version of)
>> the sch5636 superio hwmon part. Using the new watchdog timer core.
>>
>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>> ---
>>   drivers/hwmon/sch5636.c |  233 ++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 files changed, 231 insertions(+), 2 deletions(-)
>>
> [ resent to proper thread ]
>
> Given that this is no longer a pure hwmon driver, it may make sense to
> split it into separate mfd/hwmon/watchdog drivers. But on the other side
> I notice that other drivers in the hwmon directory implement watchdog
> functionality as well. Bad precedent :(. Wonder what happens with those
> watchdogs if HWMON is disabled.
>
> Not really sure if we should let this happen, or start being more
> restrictive and enforce cleaner code. Jean, any thoughts/comments ?

The problem with the 2 hwmon drivers (sch5636 and fschmd) I'm responsible
for which have a watchdog integrated is that the watchdog is part of the
same "logical unit" as the hwmon part. This actually makes sense from
a hw point of view. Various watchdogs also have functions like brownout
detection / under / over volt monitoring and temp monitoring, resetting
the system not only when the application fails to ping the watchdog,
but also on various other abnormal conditions. The watchdog API even
has some (rather crude) interfaces for getting readings for some of these
sensors embedded inside wacthdogs. Although it would be better for those
drivers that support this to just move to the sensors interface for those
parts.

So back to the 1 logical unit part, you are talking about using / creating
some sort of mfd (multi function device) framework. Actually we already have
that for the sch5636 case, it is a superio and a superio is divided into
logical devices, which usually each have their own driver. Sometimes drivers
need to touch the shared superio config space, and we've sharing mechanisms
for those in place too now a days.

But the sch5636 hardware monitoring and watchdog function are part of the
same logical device, they share the same (isa) io ports, and the same
convoluted talk to the embedded microcontroller by banging and polling
io ports communications "protocol".

I'm pretty firmly set on a one logical unit one driver model, anything
else will mean writing some sort of specialized sharing framework just
for this model IC, and then another one for the next, etc. If the
only argument against just exporting the 2 interfaces with one driver
is that the watchdog function will go away if HWMON is not enabled, waying
it against the amount of work necessary to get a clean split, I don't
find that enough of a reason for split drivers.

Also not that we will actually never have a really clean split,
since as soon as the real hardware has both functions integrated into
a single logical unit any sharing / multiplexing solution will be highly
device specific.

Actually in v4l land we are currently working on fixing a historic mistake
where for certain devices (so called dual mode cameras) we have 2 drivers
for 1 logical unit (1 usb interface). The driver infighting happening there
is not pretty and we've decided to fix this once and for all by moving
both functions into a single driver...

Regards,

Hans
