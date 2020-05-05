Return-Path: <SRS0=XVXx=6T=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C92CC47254
	for <linux-watchdog@archiver.kernel.org>; Tue,  5 May 2020 15:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3256D2078C
	for <linux-watchdog@archiver.kernel.org>; Tue,  5 May 2020 15:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgEEPkI (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 5 May 2020 11:40:08 -0400
Received: from ms.lwn.net ([45.79.88.28]:50152 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbgEEPkI (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 5 May 2020 11:40:08 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 45E12737;
        Tue,  5 May 2020 15:40:08 +0000 (UTC)
Date:   Tue, 5 May 2020 09:40:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] watchdog: update email address in conversion doc
Message-ID: <20200505094007.5449d2d2@lwn.net>
In-Reply-To: <20200502143103.19473-1-wsa@kernel.org>
References: <20200502143103.19473-1-wsa@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Sat,  2 May 2020 16:30:58 +0200
Wolfram Sang <wsa@kernel.org> wrote:

> The old one is defunct. However, I think it makes sense that I am still
> the primary contact person for updates here.
> 
> Signed-off-by: Wolfram Sang <wsa@kernel.org>
> ---
> 
> ... if there will be any. Let me know if you agree.
> 
>  Documentation/watchdog/convert_drivers_to_kernel_api.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/watchdog/convert_drivers_to_kernel_api.rst b/Documentation/watchdog/convert_drivers_to_kernel_api.rst
> index dd934cc08e40..b972ef4c7cff 100644
> --- a/Documentation/watchdog/convert_drivers_to_kernel_api.rst
> +++ b/Documentation/watchdog/convert_drivers_to_kernel_api.rst
> @@ -2,7 +2,7 @@
>  Converting old watchdog drivers to the watchdog framework
>  =========================================================
>  
> -by Wolfram Sang <w.sang@pengutronix.de>
> +by Wolfram Sang <wsa@kernel.org>

Applied, thanks.

jon
