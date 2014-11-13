Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:7577 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932651AbaKMN0o (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 13 Nov 2014 08:26:44 -0500
Message-ID: <5464B191.9020401@imgtec.com>
Date: Thu, 13 Nov 2014 13:26:41 +0000
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
Subject: Re: [PATCH 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
References: <1415805483-26268-1-git-send-email-Naidu.Tellapati@imgtec.com>	<1415805483-26268-2-git-send-email-Naidu.Tellapati@imgtec.com> <CAL1qeaHt14p3cjk7hLx_E2qKdqR+qHne-BJmHvVrgBF-4AyU=A@mail.gmail.com> <89F3BC60EA3A0141B1F6C2A661D95E5E3F192BB4@hbmail01.hb.imgtec.org>
In-Reply-To: <89F3BC60EA3A0141B1F6C2A661D95E5E3F192BB4@hbmail01.hb.imgtec.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 13/11/14 12:58, Jude Abraham wrote:
>>>  +/* timeout in seconds */
>>>  +#define PDC_WD_MIN_TIMEOUT             1
>>>  +#define PDC_WD_MAX_TIMEOUT             131072
>>> +#define PDC_WD_DEFAULT_TIMEOUT         64
>>>  +#define PDC_WD_DEFAULT_PRETIMEOUT      PDC_WD_MAX_TIMEOUT
>>>  +#define MIN_TIMEOUT_SHIFT              14  /* Clock rate 32768Hz=2^(14+1)*/
> 
>> The input clock is not fixed at 32kHz.  I believe it can be configured to run at a different rate.
> 
> I think it is  a 32 Khz fixed clock to the block. We are speaking to my hardware team for confirmation.
> We will address the review comment after receive feedback from  my hardware team.

It should ideally be 32KHz, but that doesn't mean it will be guaranteed
to be. The input clock rate is still dependent on the SoC clock setup to
provide the clock, and that can usually be reconfigured i.e. from a
dedicated external oscillator on the board if provided (hopefully
providing the right frequency), or derived from a shared oscillator of
some other frequency.

For TZ1090 SoC with this IP block, powering down the rest of the SoC
happened to reset the low power clock configuration and it would switch
clock source to the main oscillator with a fixed divide, which certainly
wasn't 32khz most of the time. Each of the low power drivers had to then
take this into account in their configuration (img-ir for IR timings,
wdt to a lesser extent, and most importantly rtc so as not to lose time
or wake up at the wrong time!).

Cheers
James
