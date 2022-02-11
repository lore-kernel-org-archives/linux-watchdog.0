Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691ECC433FE
	for <linux-watchdog@archiver.kernel.org>; Fri, 11 Feb 2022 16:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351690AbiBKQpa (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:45:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351591AbiBKQp3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 11 Feb 2022 11:45:29 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C3CD65;
        Fri, 11 Feb 2022 08:45:28 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 4so10115231oil.11;
        Fri, 11 Feb 2022 08:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0VuDosrPtUOxSIQIeO4Bd7qCohEltoGRKuxLMbZLM04=;
        b=Sn/FODfW6BKjek5S2Cd0zhyeSLLngPxTaGikTtKVPNHYbzC2VCa/rWBOJcf1hP4Fnp
         MEhBtLugHs4R/iF7TYpSRm/BynYH/rja1aveZhyEvJsXPsRZYlfFEp5F6qOvY/Fdc00x
         Ow5+6nrkk+VnAAGVBnFMAaphEMBQw31vBL6hf3nIgQFs0IPGW2GX0XxE4MO4T+kQQw9Q
         f0fDS+SIaU5ukWLRyBv8/K6bNmJ1S2FnJVo0KoQ0QwLp0BHAXkhCa0a95JaIqyS73GGj
         7QcwYzg7+At9W6g0EdGZPZZ+NES0FBnQaUoQHqjEKkTnA5cZrWs6IgWNi0dEHh0H6goF
         SKqA==
X-Gm-Message-State: AOAM53020MC94TyL7vb/J6FHNM9pXrda6Nbn7/kJ4OD4GYyvgajylwrr
        KaFzU6CI0qZdDcfzyOJ+0Q==
X-Google-Smtp-Source: ABdhPJziC2VqP8+N4WTAV17wp3i/jlaevPineRvJCejH6FV67JNjTaptkyRRDeBa1IjMmpvGKkncsA==
X-Received: by 2002:a05:6808:2086:: with SMTP id s6mr597613oiw.236.1644597928312;
        Fri, 11 Feb 2022 08:45:28 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id x1sm9355800oto.38.2022.02.11.08.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:45:27 -0800 (PST)
Received: (nullmailer pid 497474 invoked by uid 1000);
        Fri, 11 Feb 2022 16:45:25 -0000
Date:   Fri, 11 Feb 2022 10:45:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        geert+renesas@glider.be, linux-watchdog@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: watchdog: renesas,wdt: Add support
 for RZ/N1
Message-ID: <YgaSpW4QsVDKgIFo@robh.at.kernel.org>
References: <20220208183511.2925304-1-jjhiblot@traphandler.com>
 <20220208183511.2925304-3-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208183511.2925304-3-jjhiblot@traphandler.com>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Tue, 08 Feb 2022 19:35:06 +0100, Jean-Jacques Hiblot wrote:
> Describe the WDT hardware in the RZ/N1 series.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
