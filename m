Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-co1nam03on0056.outbound.protection.outlook.com ([104.47.40.56]:19795
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751127AbeCGKEj (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 7 Mar 2018 05:04:39 -0500
Date: Wed, 7 Mar 2018 11:04:04 +0100
From: Robert Richter <robert.richter@cavium.com>
To: Jayachandran C <jnair@caviumnetworks.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Fu Wei <fu.wei@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: sbsa: use 32-bit read for WCV
Message-ID: <20180307100403.GB14432@rric.localdomain>
References: <1519815140-5336-1-git-send-email-jnair@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519815140-5336-1-git-send-email-jnair@caviumnetworks.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 28.02.18 02:52:20, Jayachandran C wrote:
> According to SBSA spec v3.1 section 5.3:
>   All registers are 32 bits in size and should be accessed using
>   32-bit reads and writes. If an access size other than 32 bits
>   is used then the results are IMPLEMENTATION DEFINED.
>   [...]
>   The Generic Watchdog is little-endian
>
> The current code uses readq to read the watchdog compare register
> which does a 64-bit access. This fails on ThunderX2 which does not
> implement 64-bit access to this register.
>
> Fix this by using lo_hi_readq() that does two 32-bit reads.
>
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>

Reviewed-by: Robert Richter <rrichter@cavium.com>

I have looked into the non-atomic use of the register access and it
looks sane as the WCV register is only incremented by hardware. There
is no concurrent (write) access from the kernel.

-Robert
