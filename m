Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:54523 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807AbaKMNIa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 13 Nov 2014 08:08:30 -0500
Message-ID: <5464AD4B.1000509@imgtec.com>
Date: Thu, 13 Nov 2014 13:08:27 +0000
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
To: Jude Abraham <Jude.Abraham@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	Naidu Tellapati <Naidu.Tellapati@imgtec.com>
CC: "wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	James Hartley <James.Hartley@imgtec.com>,
	"Ezequiel Garcia" <Ezequiel.Garcia@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] DT: watchdog: Add ImgTec PDC Watchdog Timer binding
 documentation
References: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>	<1415805483-26268-3-git-send-email-Naidu.Tellapati@imgtec.com> <CAL1qeaHrjccd4KYAUMvWEKqhM9DFNyKWE=-2k0ux+76XR+Q5tQ@mail.gmail.com> <89F3BC60EA3A0141B1F6C2A661D95E5E3F192BAA@hbmail01.hb.imgtec.org>
In-Reply-To: <89F3BC60EA3A0141B1F6C2A661D95E5E3F192BAA@hbmail01.hb.imgtec.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 13/11/14 12:58, Jude Abraham wrote:
> On Wed, Nov 12, 2014 at 7:18 AM,  <Naidu.Tellapati@imgtec.com> wrote:
>>> diff --git a/Documentation/devicetree/bindings/watchdog/imgpdc-wdt.txt 

>>> +- interrupts : Should contain WDT interrupt
> 
>>  Not sure the interrupt will really be necessary.
> 
> Ok, We will remove the interrupt.

Regardless, there is still an interrupt line coming out of the WDT and
interrupt status/clear/enable registers for the single reminder
interrupt. IMO it makes sense to describe it in DT even if the driver
doesn't [yet] make use it.

BTW, please do CC me on future versions of this patchset.

Cheers
James
