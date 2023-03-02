Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3D7C7EE2F
	for <linux-watchdog@archiver.kernel.org>; Thu,  2 Mar 2023 15:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCBPPd (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 2 Mar 2023 10:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCBPPa (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Mar 2023 10:15:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD241B47;
        Thu,  2 Mar 2023 07:15:29 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B2C886602F90;
        Thu,  2 Mar 2023 15:15:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677770128;
        bh=XV5YGRZl9Mppuq8eKn/eaIf87XWA0/iCyRlIetkTC2k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dMc+k7hnvJ48+V2RlrYCycZRmICvsxNCAZV5N1tN5vG1ofhV4hlx3sxwp7UtI0LQQ
         dEyelrOEdcV3RNxjiGRw1sca7U3N4ovbpmB2c7G1tf09tj6hYafrvBW/pm9EmhYq9E
         GWZxqzNCbW0BtAqdgBGciTOFQfyrAe2G766aMs3Lz6wAwoEhMHDwy/fn475qHMql9p
         2IJIvy/cz7YYE2pEy6gJudtye9APa5szBJHYoPbQeCO5nT1bfzhuT7jNeHOyq/s70B
         DlgLNuNJm3kAq9UGmgzPwZSNgl4MF43+J7/gaQzut6ISyczgZwxmHP6OqUHDzdv6fB
         TiyZbwodmDMpA==
Message-ID: <a0913c20-81ac-6221-6bad-ad611d7aeff2@collabora.com>
Date:   Thu, 2 Mar 2023 16:15:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add binding for MediaTek MT6735
 TOPRGU/WDT
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230302124015.75546-1-y.oudjana@protonmail.com>
 <20230302124015.75546-2-y.oudjana@protonmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230302124015.75546-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Il 02/03/23 13:40, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a DT binding for the MT6735 top reset generation unit/watchdog timer.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

