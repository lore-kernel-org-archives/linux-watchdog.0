Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:43929 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023AbaKMTHx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 13 Nov 2014 14:07:53 -0500
Received: by mail-vc0-f180.google.com with SMTP id im6so1381148vcb.11
        for <linux-watchdog@vger.kernel.org>; Thu, 13 Nov 2014 11:07:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5464AD4B.1000509@imgtec.com>
References: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>
	<1415805483-26268-3-git-send-email-Naidu.Tellapati@imgtec.com>
	<CAL1qeaHrjccd4KYAUMvWEKqhM9DFNyKWE=-2k0ux+76XR+Q5tQ@mail.gmail.com>
	<89F3BC60EA3A0141B1F6C2A661D95E5E3F192BAA@hbmail01.hb.imgtec.org>
	<5464AD4B.1000509@imgtec.com>
Date: Thu, 13 Nov 2014 11:07:52 -0800
Message-ID: <CAL1qeaHEGZWs8PPrX5cNpUWXDL3D_5Y2w772eKBEO0G+5q_p-g@mail.gmail.com>
Subject: Re: [PATCH 2/2] DT: watchdog: Add ImgTec PDC Watchdog Timer binding documentation
From: Andrew Bresticker <abrestic@chromium.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Jude Abraham <Jude.Abraham@imgtec.com>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	James Hartley <James.Hartley@imgtec.com>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 13, 2014 at 5:08 AM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi,
>
> On 13/11/14 12:58, Jude Abraham wrote:
>> On Wed, Nov 12, 2014 at 7:18 AM,  <Naidu.Tellapati@imgtec.com> wrote:
>>>> diff --git a/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt
>
>>>> +- interrupts : Should contain WDT interrupt
>>
>>>  Not sure the interrupt will really be necessary.
>>
>> Ok, We will remove the interrupt.
>
> Regardless, there is still an interrupt line coming out of the WDT and
> interrupt status/clear/enable registers for the single reminder
> interrupt. IMO it makes sense to describe it in DT even if the driver
> doesn't [yet] make use it.

Yes, you're right.  Even if we don't currently use the interrupt, it's
a correct description of the hardware.
