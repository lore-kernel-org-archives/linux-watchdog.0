Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:54634 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933486AbaKNDSi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 13 Nov 2014 22:18:38 -0500
From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
To: Andrew Bresticker <abrestic@chromium.org>,
	James Hogan <James.Hogan@imgtec.com>
CC: Jude Abraham <Jude.Abraham@imgtec.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	James Hartley <James.Hartley@imgtec.com>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 2/2] DT: watchdog: Add ImgTec PDC Watchdog Timer binding
 documentation
Date: Fri, 14 Nov 2014 03:18:30 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2F505B85@hbmail01.hb.imgtec.org>
References: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>
	<1415805483-26268-3-git-send-email-Naidu.Tellapati@imgtec.com>
	<CAL1qeaHrjccd4KYAUMvWEKqhM9DFNyKWE=-2k0ux+76XR+Q5tQ@mail.gmail.com>
	<89F3BC60EA3A0141B1F6C2A661D95E5E3F192BAA@hbmail01.hb.imgtec.org>
	<5464AD4B.1000509@imgtec.com>,<CAL1qeaHEGZWs8PPrX5cNpUWXDL3D_5Y2w772eKBEO0G+5q_p-g@mail.gmail.com>
In-Reply-To: <CAL1qeaHEGZWs8PPrX5cNpUWXDL3D_5Y2w772eKBEO0G+5q_p-g@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi James Hogan & Andrew,

Many thanks for your feedback.


> On Thu, Nov 13, 2014 at 5:08 AM, James Hogan <james.hogan@imgtec.com> wrote:
>> Hi,
>>
>> On 13/11/14 12:58, Jude Abraham wrote:
>>> On Wed, Nov 12, 2014 at 7:18 AM,  <Naidu.Tellapati@imgtec.com> wrote:
>>>>> diff --git a/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
>>
>>>>> +- interrupts : Should contain WDT interrupt
>>>
>>>>  Not sure the interrupt will really be necessary.
>>>
>>> Ok, We will remove the interrupt.
>>
>> Regardless, there is still an interrupt line coming out of the WDT and
>> interrupt status/clear/enable registers for the single reminder
>> interrupt. IMO it makes sense to describe it in DT even if the driver
>> doesn't [yet] make use it.

> Yes, you're right.  Even if we don't currently use the interrupt, it's
> a correct description of the hardware.

OK. We will describe the interrupt in DT. But we will remove all references
to pre-timeout & interrupt from the driver code.


Regards,
Naidu.
