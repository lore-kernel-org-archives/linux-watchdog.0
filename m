Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF9C56201
	for <linux-watchdog@archiver.kernel.org>; Wed, 25 Nov 2020 08:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4287820857
	for <linux-watchdog@archiver.kernel.org>; Wed, 25 Nov 2020 08:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgKYIjz (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:39:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33473 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgKYIjy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 25 Nov 2020 03:39:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id u12so1049575wrt.0
        for <linux-watchdog@vger.kernel.org>; Wed, 25 Nov 2020 00:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KSWzHwPTJ4FQ6+y4i94jaJD/zqU4PZY71ye/ckNg5K4=;
        b=s0IRBKvfd2Z9Llg0TlozLUhOae+Lky+VNgQV3VGHSNsSs9WsJRPePb5CLileozbdkl
         WwB6E+kmpweoOx11NNoWmZdOCB0z8M819vAvJNAeOOmcxhQ/ZCHxU/Exg+SNl582uv1W
         QQmjntExTkuyq3RIlSbIEp8aYwva6ALjNg31gmCLECwfEgW42C6TfUP1AiVBE21N0mLv
         aRckL1nggZ5hgiV845H1H8dEt4sJmzzRXMj/skL1l+o+gNWbs6QoUBlhu/2pXjQR1XSD
         2YRZ/P9qo3SA12rUwKxRkJfgybseWw0WKJCCxVLpA00b2PnjZpo4rFCq4b3OrLgNE9Gt
         UB6w==
X-Gm-Message-State: AOAM532YOEadmf1E5kKLVywsf/4gJuHSWnb61AFNebq7Zi2derX692Tn
        ROrYN2MzgxMmx+5qFISggjs=
X-Google-Smtp-Source: ABdhPJwCl0iPyCTYqaBzwVx6ZRDUwyrhNXefDYIOJ/w2TSwtezlX3NXFGImhZA27+jKN8se/nY3GvA==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr2775210wri.314.1606293592554;
        Wed, 25 Nov 2020 00:39:52 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id d8sm3569144wrp.44.2020.11.25.00.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 00:39:51 -0800 (PST)
Date:   Wed, 25 Nov 2020 09:39:50 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wang Li <wangli74@huawei.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: rti-wdt: disable runtime pm in case of
 failure
Message-ID: <20201125083950.GA8488@kozik-lap>
References: <20201125082956.3325066-1-wangli74@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125082956.3325066-1-wangli74@huawei.com>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, Nov 25, 2020 at 04:29:56PM +0800, Wang Li wrote:
> In case of runtime pm failed, should disable runtime pm.
> 
> Fixes: 2d63908bdbfb ("watchdog: Add K3 RTI watchdog support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Li <wangli74@huawei.com>
> ---
> Changelog:
> v2
> - Change the fix tag.
> ---
>  drivers/watchdog/rti_wdt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
