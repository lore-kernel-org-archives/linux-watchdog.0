Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40148 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513AbbLWQLW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Dec 2015 11:11:22 -0500
Subject: Re: [PATCH v8] watchdog: ts4800: add driver for TS-4800 watchdog
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
References: <1449592648-22701-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <20151223154359.GA6265@localhost>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>, kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <567AC7A5.1050005@roeck-us.net>
Date: Wed, 23 Dec 2015 08:11:17 -0800
MIME-Version: 1.0
In-Reply-To: <20151223154359.GA6265@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/23/2015 07:43 AM, Damien Riegel wrote:
> On Tue, Dec 08, 2015 at 11:37:28AM -0500, Damien Riegel wrote:
>> This watchdog is instantiated in a FPGA that is memory mapped. It is
>> made of only one register, called the feed register. Writing to this
>> register will re-arm the watchdog for a given time (and enable it if it
>> was disable). It can be disabled by writing a special value into it.
>>
>> It is part of a syscon block, and the watchdog register offset in this
>> block varies from board to board. This offset is passed in the syscon
>> property after the phandle to the syscon node.
>>
>> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Hi Guenter,
>
>
> You have reviewed this patch but not picked it up in your tree. Shall I
> expect Wim to pick it up directly for the next merge window? The board
> would be quite useless without its watchdog driver.
>
My tree is in pretty bad shape right now; It includes some older patches
which have to be replaced. I'll have to rebase it against Wim's tree
and clean it up. Hope I can do that before the weekend.

But, yes, of course, Wim can pick up your patch directly.

Guenter

