Return-Path: <SRS0=zQ0A=BA=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37554C433F8
	for <linux-watchdog@archiver.kernel.org>; Tue, 21 Jul 2020 02:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F902077D
	for <linux-watchdog@archiver.kernel.org>; Tue, 21 Jul 2020 02:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595299924;
	bh=ILyTACez6OzFt2wtQwxR8zLeTeUxB8fbxJ4gtw5a2hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ppv1K6ZjhBvL3R6BUcDbdnUR4zaFdB4uyBpA8Vp4pGDiQHcuGHhzg0X9o0ndRALDL
	 8e+j8SxR8zmtMNIXg48ja+DhVqkT/YCdIXztL5DdykOY+7TvZqim5KpfS2NEyh2Mhv
	 H7H9WLUT3K6u6LGtIItMa6jrbJi7D5dDBFpUimuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgGUCv7 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:51:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36701 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgGUCv6 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Jul 2020 22:51:58 -0400
Received: by mail-io1-f68.google.com with SMTP id y2so19837955ioy.3;
        Mon, 20 Jul 2020 19:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVmgKeTEtQQOUuV3Vd+cEAEoEU2MIUHzuf4rcIbikDg=;
        b=WvyZzP9w62WZqmN0bpcj2qKeQzdSBRiSZbAK6f/6OmCFHYnpyNrhyvAeE9T0DnwXGU
         CaxTkip+7qgH2VVs4CXyl2JYpaTRcCC0TncXjLZKU3vKa/N/6ARFKFWP1Hgz9fQZq2S+
         CbF5G+RkXraoplGQ3XjwnASbdXgx6mj+RLiT+WwaPjzyvfzOlZpnoQICnX4rtOAwzkkk
         LMzuL7862xj9bpHR0DCi6vttjoL7/cPUmIU5qCukZ5u8aKjs7nP1pcOXQJhxl/IyhwQS
         2nBuZo1uuwK/BrU1SD/aJtN3KJhftNlFRjVcutGyGZSGdzXpdcNGpnSrnDpqGDqUN6Aw
         cH/Q==
X-Gm-Message-State: AOAM532AvP/GrzJGnIyIvCBToaHzSoU+08bcYOvOwHTov0EB1534kPMt
        92mjNZBfQC8VIIJhThIqTA==
X-Google-Smtp-Source: ABdhPJzGeOafra3vktGCSEAE4Prf6Bx1+RmEWY5ZEWVedpyAyyU4Ju3PY9aJsKNijHrkvI3CJVyw2A==
X-Received: by 2002:a02:3c08:: with SMTP id m8mr28967389jaa.107.1595299916723;
        Mon, 20 Jul 2020 19:51:56 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r23sm936823iob.42.2020.07.20.19.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 19:51:56 -0700 (PDT)
Received: (nullmailer pid 3446478 invoked by uid 1000);
        Tue, 21 Jul 2020 02:51:54 -0000
Date:   Mon, 20 Jul 2020 20:51:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Niklas <niklas.soderlund@ragnatech.se>,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Mark Brown <broonie@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-i2c@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        linux-can@vger.kernel.org
Subject: Re: [PATCH 14/20] dt-bindings: spi: renesas,sh-msiof: Add r8a774e1
 support
Message-ID: <20200721025154.GA3446430@bogus>
References: <1594811350-14066-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594811350-14066-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594811350-14066-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, 15 Jul 2020 12:09:04 +0100, Lad Prabhakar wrote:
> Document RZ/G2H (R8A774E1) SoC bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
