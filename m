Return-Path: <SRS0=jutC=7J=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB99DC433E0
	for <linux-watchdog@archiver.kernel.org>; Wed, 27 May 2020 17:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83FA20DD4
	for <linux-watchdog@archiver.kernel.org>; Wed, 27 May 2020 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590599757;
	bh=DmkWu4p3uiFJtjCdJCSH3WMauJ+B8g0HGW0R5W/y3nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dAj+G27UNBZXGVaTG6ZOCm9LuV/1rGT2KzQ1tD0wrXft6XFJi5lmuDMuyO1N0VJxY
	 uawvCJRo6vqw1tSWZRAB1QiXtn4NgVOEXwCwAypNG0jZ2f5qmEXJXEhkIbQeZeFo5n
	 wC0GaG/urGukJNdzZyXtX1m9B+rNgqVtWGA9Z2E4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbgE0RPy (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 27 May 2020 13:15:54 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37202 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgE0RPx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 27 May 2020 13:15:53 -0400
Received: by mail-il1-f195.google.com with SMTP id r2so13639128ila.4;
        Wed, 27 May 2020 10:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=99jkXJtnw0P2GQYZjU0aScSsUNY825EbLFpq6MuWBZM=;
        b=gsK2/YiiuDQiYj2U23kEWnRx9vTN7MHgQYmT+E+G4Syje5gcrHrL9CRzLG6E6Hko1Y
         5B5lKW5OJfV6n4nR9k3KlZq2oX++5i0f5Evuc9xzKr8MyyQ7WpeeGyuqa6qU7g5AXBgq
         z5lULyBJGaqnfK0xiICXgXUWK5VZoFJTDlxXnGX62kwYtze3tSEdvh9UlEXP+Pu3wq85
         17tzNsNlJgZyxfzNE9IoJogzTf9XXDcqtNAdoXyBAAd/GqtTaMHEJ7uv2sQovINAWg2O
         r+TxFlyQhlQ0ibn98NKkceazfhmKNoEgpSJYcmmFJU6UggsPuTusjHLIVoSAtHb9MCVK
         71/Q==
X-Gm-Message-State: AOAM530pmrvwV3rpPeCYsMT2ziVgAXbfF05UF5+IfSmYiN5snmcIbnoU
        HBk354kg7W5CPhfmax5/TkXTYOM=
X-Google-Smtp-Source: ABdhPJwPTefjiDIOFvVJXCs7TY5ht51jwG0qsC72o6krduJg/Kg+szG4VgXRZmELzJcCA5WCHlNh1g==
X-Received: by 2002:a92:d183:: with SMTP id z3mr7109934ilz.102.1590599752632;
        Wed, 27 May 2020 10:15:52 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g6sm1881136ile.38.2020.05.27.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:15:52 -0700 (PDT)
Received: (nullmailer pid 2365435 invoked by uid 1000);
        Wed, 27 May 2020 17:15:51 -0000
Date:   Wed, 27 May 2020 11:15:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: watchdog: renesas,wdt: Document r8a7742
 support
Message-ID: <20200527171551.GA2365256@bogus>
References: <1590596967-22973-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590596967-22973-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, 27 May 2020 17:29:27 +0100, Lad Prabhakar wrote:
> RZ/G1H (R8A7742) watchdog implementation is compatible with R-Car Gen2,
> therefore add relevant documentation.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Hi,
> 
> This patch is part of series [1], as requested by Rob [1] I have
> reabsed my changes on-top json-schema conversion patch.
> 
> [1] https://www.spinics.net/lists/netdev/msg653258.html
> [2] https://patchwork.kernel.org/patch/11552335/
> 
> Cheers,
> Prabhakar
> ---
>  Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
