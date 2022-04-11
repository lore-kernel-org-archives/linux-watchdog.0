Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9993C4332F
	for <linux-watchdog@archiver.kernel.org>; Mon, 11 Apr 2022 01:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiDKBwp (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 10 Apr 2022 21:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbiDKBwi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 10 Apr 2022 21:52:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27595FC4;
        Sun, 10 Apr 2022 18:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8850FB80EE9;
        Mon, 11 Apr 2022 01:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2DCC385A1;
        Mon, 11 Apr 2022 01:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649641819;
        bh=ByY0sdWTAs2XT4Hm/H478dHxYG7AkIMFXZr3r45qlrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAI0Z89hW9+Gjd/2InbALkPBGDtGA57UOAQPQW13c2QGIhSJUwLoyGpN+5YzpQTdN
         0Gp3BNnW2mFXSKf8oNu2LxRGpiYRhpjUmSMwphU2OsIBe6czIhuDoI1jIrd15595dZ
         UFgPqBw3r0IJ2/QA38pMJmXgYhb3GOaT13gvyD827fK/YVNlechqcH3yMKIgwlXWmA
         wbyUkjyhgOIW0wZxLWPazqqwIoG0VmUwL30HN/vqP8Q4dFxp3Z4kuxR9j7QXuUM4i8
         mZVUYTQQu7dhBXsoNBT3FAO80PJHe+UUMFcA4wMAC1T3uCgUC7HarCT/HAA0MyWZWa
         a3/t3qOyphYKQ==
Date:   Mon, 11 Apr 2022 01:50:15 +0000
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     linux@roeck-us.net, wim@linux-watchdog.org,
        geert+renesas@glider.be, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v5 2/2] watchdog: Add Renesas RZ/N1 Watchdog driver
Message-ID: <YlOJVzA49rTrBDH3@google.com>
References: <20220408200205.2833931-1-jjhiblot@traphandler.com>
 <20220408200205.2833931-3-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408200205.2833931-3-jjhiblot@traphandler.com>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Fri, Apr 08, 2022 at 10:02:05PM +0200, Jean-Jacques Hiblot wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
> 
> This is a driver for the standard WDT on the RZ/N1 devices. This WDT has
> very limited timeout capabilities. However, it can reset the device.
> To do so, the corresponding bits in the SysCtrl RSTEN register need to
> be enabled. This is not done by this driver.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

With a minor comment:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> +static int rzn1_wdt_probe(struct platform_device *pdev)
> +{
[...]
> +	wdt->wdtdev.timeout = DEFAULT_TIMEOUT;
> +	ret = watchdog_init_timeout(&wdt->wdtdev, 0, dev);

Could it drop the assignment if `ret` is unused?
