Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33165 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdCKR2x (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 11 Mar 2017 12:28:53 -0500
Date: Sat, 11 Mar 2017 19:28:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/8] watchdog: s3c2410: Remove confusing CONFIG prefix
 from local defines
Message-ID: <20170311172841.plxclb45qyp6yyqd@kozik-lap>
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170311172527.16368-2-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Mar 11, 2017 at 07:25:20PM +0200, Krzysztof Kozlowski wrote:
> The CONFIG prefix from defines in the s3c2410_wdt.c might suggest that
> these constants come from Kconfig.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/s3c2410_wdt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>

Ah, my mistake, I looked at watchdog-master but this is already in
watchdog-next. Sorry for confusion.

Best regards,
Krzysztof

