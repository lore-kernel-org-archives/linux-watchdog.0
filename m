Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58906 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757657Ab2CSKAr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Mar 2012 06:00:47 -0400
Message-ID: <4F670420.4090906@redhat.com>
Date: Mon, 19 Mar 2012 11:02:08 +0100
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Guenter Roeck <guenter.roeck@ericsson.com>
CC: Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] [PATCH] hwmon/sch56xx: Add support for the integrated
 watchdog (v2)
References: <1332072308-4404-1-git-send-email-hdegoede@redhat.com> <20120318121703.GB26167@ericsson.com> <20120318215015.GA28033@ericsson.com>
In-Reply-To: <20120318215015.GA28033@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 03/18/2012 10:50 PM, Guenter Roeck wrote:
> On Sun, Mar 18, 2012 at 08:17:03AM -0400, Guenter Roeck wrote:
>> On Sun, Mar 18, 2012 at 08:05:08AM -0400, Hans de Goede wrote:
>>> Add support for the watchdog integrated into the SMSC SCH5627 and
>>> SCH5636 superio-s. Since the watchdog is part of the hwmon logical device
>>> and thus shares ioports with it, the watchdog driver is integrated into the
>>> existing hwmon drivers for these.
>>>
>>> Note that this version of the watchdog support for sch56xx superio-s
>>> implements the watchdog chardev interface itself, rather then relying on
>>> the recently added watchdog core / watchdog_dev. This is done because
>>> currently some needed functionality is missing from watchdog_dev, as soon
>>> as this functionality is added (which is being discussed on the
>>> linux-watchdog mailinglist), I'll convert this driver over to using
>>> watchdog_dev.
>>>
>>> Changes in v2:
>>> -fix checkpatch complaints
>>> -follow multi-line comment style guidelines
>>>
>>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>>
>> You are too fast ;-). Unfortunately, we'll need v3, with the slab.h include.
>>
> Forget v3 - I added the include myself and applied the patch. Not worth missing
> the commit window due to a missing include.

Thanks!

Regards,

Hans
