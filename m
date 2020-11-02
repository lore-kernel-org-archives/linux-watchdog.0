Return-Path: <SRS0=opv0=EI=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27304C00A89
	for <linux-watchdog@archiver.kernel.org>; Mon,  2 Nov 2020 17:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C0B2225E
	for <linux-watchdog@archiver.kernel.org>; Mon,  2 Nov 2020 17:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604337771;
	bh=6TmnjjjTgAMnpSFU/1+JJeindeFpRoKwe4y0LsVKuIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JK8Tt4nI/HTUZ2DZrBL9vIayELdVrFAeIsZ1lehROlkSzfBwxC9Grf6FojrTY1yRc
	 fEkR64xJijC+WNShpCZ/zP6r/A7CqkzF8Lh3NNld+nonEXu0aFCD1oxEMCcPtpBLtm
	 q2wYqQ6niATU7IA/ClDiOJOzb9I5oNMyBHV3XZ74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgKBRWv (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:22:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37290 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKBRWv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 2 Nov 2020 12:22:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id 6so6263176oiy.4;
        Mon, 02 Nov 2020 09:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BoGuZDf+gcgJdy19B81Nls3yf/BPcFoPGb+jylySIwQ=;
        b=GSVJc/fLve/SFrLoudmGqb7Gel+7crI/Ieq8xMRREf8WWA2peGmS/9Fgjh/3JxIILj
         xUU8CeZrwXM9t73ILEvO1U3bGcuCkxIysEsl/UEFdTXnujSfkL4bKljOQopRzKyxHwMU
         raITRK05RF4ok2HCsK2zRSS+eHPg2+jlAit9lTdGtwb7KXuNzepPYehYb8Mv2T2nCzOg
         abZCEX40GSRLCBJh6op8Z9MsX6nSHxWbOgQ7ANJSEjzrnTpRImbR5u6PI6KASfnJQDXb
         FYRHwNxQDH838w+KaFcenM8CQbzbwD79bPE1X55rA4Rs3Ng4PksMhsoGq9LdfP6KWNt+
         KezA==
X-Gm-Message-State: AOAM530IkpUq0APwv0sa3o6Aih7KA4151CnHYc+MBTAtWRnmI37XxrU1
        Ff1PQLmpB7KG0hyMuaXmGA==
X-Google-Smtp-Source: ABdhPJy7vp8vUN4JrR4flDjF3M4xU4BGlLQ5upUEBnh8c0gr1MPcsKspvchkKijLu4TxEHRSFaUHcQ==
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr10826013oib.106.1604337769811;
        Mon, 02 Nov 2020 09:22:49 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n18sm3777538otk.33.2020.11.02.09.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:22:49 -0800 (PST)
Received: (nullmailer pid 4074637 invoked by uid 1000);
        Mon, 02 Nov 2020 17:22:48 -0000
Date:   Mon, 2 Nov 2020 11:22:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     vijayakannan.ayyathurai@intel.com
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v1 2/2] dt-bindings: watchdog: Add bindings for Intel
 Keem Bay SoC
Message-ID: <20201102172248.GB4073001@bogus>
References: <cover.1604292525.git.vijayakannan.ayyathurai@intel.com>
 <3aa5d9e2031b4646b7f0c9831f4ea9cafffb2691.1604292525.git.vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa5d9e2031b4646b7f0c9831f4ea9cafffb2691.1604292525.git.vijayakannan.ayyathurai@intel.com>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Mon, Nov 02, 2020 at 01:23:12PM +0800, vijayakannan.ayyathurai@intel.com wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> 
> Add Device Tree binding document for Watchdog IP in the Intel Keem Bay SoC.
> 
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> Acked-by: Mark Gross <mgross@linux.intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  .../bindings/watchdog/intel,keembay-wdt.yaml  | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/intel,keembay-wdt.yaml

With the indentation fixed,

Reviewed-by: Rob Herring <robh@kernel.org>
