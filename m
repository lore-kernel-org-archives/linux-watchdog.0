Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACADC4338F
	for <linux-watchdog@archiver.kernel.org>; Thu, 29 Jul 2021 22:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9F460FD7
	for <linux-watchdog@archiver.kernel.org>; Thu, 29 Jul 2021 22:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhG2Wjy (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 29 Jul 2021 18:39:54 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:45842 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhG2Wjy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 29 Jul 2021 18:39:54 -0400
Received: by mail-io1-f54.google.com with SMTP id l126so9092637ioa.12;
        Thu, 29 Jul 2021 15:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XlptD/tZIHvjx581AafuTapU2M/nw56BX9ZwEjQcLOM=;
        b=apx2VH11L1JSSM0BAXxk+cGuK3Vz+ECuRtTfvb2jhokdicD2pBIeCvp6oGm0adhJ7+
         hKbLIaVyP30wbwD3XRtP3rURlYWG9my5k0GY9s3uKVjQa/obSjKyyXgHplecOz2apmy8
         qaONTpoBqgcyh3TtWuF6E3XIt+VoeMqV730XdQ8ZlfcNDUKSSubt2tvCacw57bjqSE2H
         uhkCVDj4hIvmOKh9rTg9ij70czbfPC/YOnw1nCjrnNanAlemNaKXOeD251j1brT/YXV/
         ++XlCLzG1mB0jt3Cz4E335mgu5Mh5mKC4DSBow5fCm0uBL/WVrIlCFe6jMq/by6ZSdMQ
         DJHw==
X-Gm-Message-State: AOAM532IpjSLAiQkbXGqpskdOrq9NwhrzRJDL503nuxH0bxT4SzRexgi
        V6fgWblZRUYFKL/l7KL7oA==
X-Google-Smtp-Source: ABdhPJzJOkvgxA1BTZ4PAi4OWpI9cFABggjmNMgJcaQ7V8JKyLgCLbuj+pSyPTNZmoVNLJoo924bRQ==
X-Received: by 2002:a02:90cb:: with SMTP id c11mr6480022jag.53.1627598389390;
        Thu, 29 Jul 2021 15:39:49 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id w14sm3078200ioa.47.2021.07.29.15.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:39:48 -0700 (PDT)
Received: (nullmailer pid 1035245 invoked by uid 1000);
        Thu, 29 Jul 2021 22:39:47 -0000
Date:   Thu, 29 Jul 2021 16:39:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Samuel Holland <samuel@sholland.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: watchdog: sunxi: Add compatible for D1
Message-ID: <YQMuM2McwNGzqAhe@robh.at.kernel.org>
References: <20210726035143.53132-1-samuel@sholland.org>
 <20210726035143.53132-2-samuel@sholland.org>
 <20210729042449.GA1716994@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729042449.GA1716994@roeck-us.net>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, Jul 28, 2021 at 09:24:49PM -0700, Guenter Roeck wrote:
> On Sun, Jul 25, 2021 at 10:51:42PM -0500, Samuel Holland wrote:
> > D1 keeps the same register layout and clock sources as the R329, but it
> > adds a key field which must be set to update the watchdog's "CFG" and
> > "MODE" registers. Therefore it is not backward-compatible.
> > 
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> >  .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml   | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> > index 853ceb1b7c0f..756e6ab99860 100644
> > --- a/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml
> > @@ -29,6 +29,7 @@ properties:
> >        - items:
> >            - const: allwinner,suniv-f1c100s-wdt
> >            - const: allwinner,sun4i-a10-wdt
> > +      - const: allwinner,sun20i-d1-wdt
> 
> Alignment is off.

No, it's correct. It's not part of the above list, but a new 'oneOf' 
entry.

Rob
