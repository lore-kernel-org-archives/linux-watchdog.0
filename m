Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35789 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbbC3SQU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Mar 2015 14:16:20 -0400
Received: by igcau2 with SMTP id au2so83061131igc.0
        for <linux-watchdog@vger.kernel.org>; Mon, 30 Mar 2015 11:16:19 -0700 (PDT)
Message-ID: <551992F0.5050809@gmail.com>
Date: Mon, 30 Mar 2015 11:16:16 -0700
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: Aaro Koskinen <aaro.koskinen@iki.fi>
CC: Wim Van Sebroeck <wim@iguana.be>,
	David Daney <david.daney@cavium.com>,
	linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] watchdog: octeon: convert to WATCHDOG_CORE API
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/28/2015 11:05 AM, Aaro Koskinen wrote:
> Convert OCTEON watchdog to WATCHDOG_CORE API. This enables support
> for multiple watchdogs on OCTEON boards.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>   drivers/watchdog/Kconfig           |   1 +
>   drivers/watchdog/octeon-wdt-main.c | 185 ++++++++-----------------------------
>   2 files changed, 39 insertions(+), 147 deletions(-)
>
[...]

You didn't seem to say how it was tested.

If you have verified that "echo > /dev/watchdog" produces register dumps 
and reboots the board, then the whole series:

Acked-by: David Daney <david.daney@cavium.com>



Thanks for doing this, I had been meaning to make the conversion myself.

David.



