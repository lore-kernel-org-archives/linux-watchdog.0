Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:28564 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890AbaKNNIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Nov 2014 08:08:18 -0500
From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
To: James Hogan <James.Hogan@imgtec.com>,
	Jude Abraham <Jude.Abraham@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>
CC: "wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	James Hartley <James.Hartley@imgtec.com>,
	"Ezequiel Garcia" <Ezequiel.Garcia@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
Date: Fri, 14 Nov 2014 13:08:11 +0000
Message-ID: <27E62D98F903554192E3C13AFCC91C3C2F505E3E@hbmail01.hb.imgtec.org>
References: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>
	<1415805483-26268-2-git-send-email-Naidu.Tellapati@imgtec.com>
 <CAL1qeaHt14p3cjk7hLx_E2qKdqR+qHne-BJmHvVrgBF-4AyU=A@mail.gmail.com>
 <89F3BC60EA3A0141B1F6C2A661D95E5E3F192BB4@hbmail01.hb.imgtec.org>,<5464B191.9020401@imgtec.com>
In-Reply-To: <5464B191.9020401@imgtec.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi James & James,

> On 13/11/14 12:58, Jude Abraham wrote:
>>>>  +/* timeout in seconds */
>>>>  +#define PDC_WD_MIN_TIMEOUT             1
>>>>  +#define PDC_WD_MAX_TIMEOUT             131072
>>>> +#define PDC_WD_DEFAULT_TIMEOUT         64
>>>>  +#define PDC_WD_DEFAULT_PRETIMEOUT      PDC_WD_MAX_TIMEOUT
>>>>  +#define MIN_TIMEOUT_SHIFT              14  /* Clock rate 32768Hz=2^(14+1)*/
>>
>>> The input clock is not fixed at 32kHz.  I believe it can be configured to run at a different rate.
>>
>> I think it is  a 32 Khz fixed clock to the block. We are speaking to my hardware team for confirmation.
>> We will address the review comment after receive feedback from  my hardware team.

> It should ideally be 32KHz, but that doesn't mean it will be guaranteed
> to be. The input clock rate is still dependent on the SoC clock setup to
> provide the clock, and that can usually be reconfigured i.e. from a
> dedicated external oscillator on the board if provided (hopefully
> providing the right frequency), or derived from a shared oscillator of
> some other frequency.

> For TZ1090 SoC with this IP block, powering down the rest of the SoC
> happened to reset the low power clock configuration and it would switch
> clock source to the main oscillator with a fixed divide, which certainly
> wasn't 32khz most of the time. Each of the low power drivers had to then
> take this into account in their configuration (img-ir for IR timings,
> wdt to a lesser extent, and most importantly rtc so as not to lose time
>or wake up at the wrong time!).

Please suggest us any valid minimum and maximum clock rates for the Watchdog on Pistachio.

Thanks and regards,
Naidu.