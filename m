Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36826 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495AbcCCVP6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2016 16:15:58 -0500
MIME-Version: 1.0
In-Reply-To: <20160303210712.GA7692@rob-hp-laptop>
References: <1456507177-5502-1-git-send-email-joshua.henderson@microchip.com> <20160303210712.GA7692@rob-hp-laptop>
From: Rob Herring <robh@kernel.org>
Date: Thu, 3 Mar 2016 15:15:35 -0600
Message-ID: <CAL_JsqL7Ez9uXFU1+9pRmpmXihffHyXFHMccJ3Zj9oTy9jQLVQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt/bindings: Add bindings for PIC32 watchdog peripheral
To: Joshua Henderson <joshua.henderson@microchip.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 3, 2016 at 3:07 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Feb 26, 2016 at 10:19:27AM -0700, Joshua Henderson wrote:
>> Document the devicetree bindings for the watchdog peripheral found on
>> Microchip PIC32 SoC class devices.
>>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> ---
>> Note: Please merge this patch series through the MIPS tree.
>
> Acked-by: Rob Herring <robh@kernel.org>

My mail to Joshua bounced, so I wouldn't merge until that is sorted:

<joshua.henderson@microchip.com>: host mx.microchip.com[198.175.253.14] said:
    550 Mailbox unavailable or access denied - <joshua.henderson@microchip.com>
    (in reply to RCPT TO command)

Rob
