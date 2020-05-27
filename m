Return-Path: <SRS0=jutC=7J=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F21AC433E0
	for <linux-watchdog@archiver.kernel.org>; Wed, 27 May 2020 19:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4642020B80
	for <linux-watchdog@archiver.kernel.org>; Wed, 27 May 2020 19:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590608012;
	bh=Pq+rxZUMqNHTw/5lfv1Xy78GvJezZInVlXGQVAaZCVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jhcMcoMb6SutGkwwsqoOMnEM4PNDwxbDeLRSxIR50pQAZq7JcQqQ4B8yKEAuf/c0M
	 QYEjK9tPnWj3nA8yNzYCl5OJUrCenLztdW9WAmarlhRuqsObEmR30boIYnJfSf51o8
	 elRqV4KNPgRFLN1P1N4Z5Aot1yKn7OdJe2DXMBPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgE0Td3 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 27 May 2020 15:33:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34263 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE0Td2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 27 May 2020 15:33:28 -0400
Received: by mail-io1-f67.google.com with SMTP id f3so27442628ioj.1;
        Wed, 27 May 2020 12:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W3JSjQKNUTVDwq2jZfNyE8OlRvobHjfbDFjoKiJceQk=;
        b=soe1lxQ6KCUovy/wCCVQfmdS/kkskn7vpqztuoVaxgE1rjOYrEcZGmxquccJPJvKdB
         NXcOTZZnay7m9WbtzbVmZTk9IflsuIN6oPgCcz0hQn4Pf8WrbF27SZFbBEEN2Li1W2Iw
         4vstvuRR8v6WlH3zC6P4MHzhO6EvHw0iF/vvbvsko9iqfvPA4zmsDIr5Q0ayy3SFz+O3
         jFjj5mtHVHp+l0mhfaDaacibfKmlt5OLCvJoDaXZt3gSoQjsX60W0eeE6+bJHWyzwG1K
         wDYfQVZwSbp7+BllR4/hbz1Nm3E32jwSpBiflwqLQXD7mwjjHuC5hQAdFsJJvNybp0ff
         7GRw==
X-Gm-Message-State: AOAM532xkYCF1X3aEQc3aLn7U0HHxSQKdrIhM2knikBK8UrqI+hFXFB7
        EUqGlQnhAbAUB2f9/fKKzg==
X-Google-Smtp-Source: ABdhPJxRWfw0O6HofA51rJdaC3d5All8AHRJ9jL/XoXkz1mv9qFlW+eJj6Id/+SWWdbo4NPhKdWj2w==
X-Received: by 2002:a02:4d:: with SMTP id 74mr7144801jaa.141.1590608007841;
        Wed, 27 May 2020 12:33:27 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t17sm2037371ilm.7.2020.05.27.12.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:33:27 -0700 (PDT)
Received: (nullmailer pid 2604073 invoked by uid 1000);
        Wed, 27 May 2020 19:33:26 -0000
Date:   Wed, 27 May 2020 13:33:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: Re: [PATCH] dt-bindings: watchdog: Convert UniPhier watchdog timer
 to json-schema
Message-ID: <20200527193326.GA2604024@bogus>
References: <1589348545-22244-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589348545-22244-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, 13 May 2020 14:42:25 +0900, Kunihiko Hayashi wrote:
> Convert UniPhier watchdog timer binding to DT schema format.
> 
> Cc: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/watchdog/socionext,uniphier-wdt.yaml  | 36 ++++++++++++++++++++++
>  .../devicetree/bindings/watchdog/uniphier-wdt.txt  | 20 ------------
>  2 files changed, 36 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
> 

Applied, thanks!
