Return-Path: <SRS0=d+ns=SK=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1101C10F13
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 20:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B5620857
	for <linux-watchdog@archiver.kernel.org>; Mon,  8 Apr 2019 20:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/bBTkcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDHUpM (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:45:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39265 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfDHUpM (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 8 Apr 2019 16:45:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so12509277ljg.6
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Apr 2019 13:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cW18gb8JokVDQ7+KXr9n9rPMx9uHcP2wB83oXVmU9QY=;
        b=L/bBTkcVtk15xOyveNlUvlynUmAXMVa6bchdC/nGlHmKCgheVL8IAA8YA2qJDIpTXr
         +2UOs+gqzvbLzPvjSLKwg17Ams0hvIF061SuJxZp6JOYBNMx1dJiOz+IN0tm7VPtGSD9
         ab4ThCixOOTFDW+NPcKCZhgbTlpz1X9bWrxBDzPDnGflexxzcsr1jFn4+EPKe1+Lijnb
         hY9PFe0KCABLxSW2Ibf2hblmvuo2eP0I4xpkoSA2ttjwgsmoZ+cmggmU+a4VtukaTCbl
         +Z3Nn6ouYLLbeUcCVbCVCYST9UmZhCOKDFMrM36NS2OKa7ftRhboEWVv/Qfr0/vCkuPx
         RoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cW18gb8JokVDQ7+KXr9n9rPMx9uHcP2wB83oXVmU9QY=;
        b=kbdjBtfmQPvnxO7TftBSAMLOEMVf82WJ5+aM3Vm+7i0vh6aw5oXuQPxzesxTztR8Lc
         2achK7jRBxIneCWUmSdjSZsdWg0FoQBITGVwdnWsVZNb5/qaRWsibOmQcMw76Jmd1eFc
         BFUXNo30zMRbthACwpIJqobfvnjr2rmkSzlKcukMVzCpLV5TpUKIFkBaeMc1C1792lGM
         bGXUyKK2sy0uoEazYkcFIC3cnnjwuIBOIYmwUep652DTKl9YAld99WLvgGp0yNwD1cLa
         +0mJxstgSfjlS3aXeXW/4sMmYzVsOG7KVbg+wtsX4KkvmFT9m7PSFCvYTS9Dl6f4oF6v
         ICXw==
X-Gm-Message-State: APjAAAV5yHU1xo6HLbBqXNYCZqvwNER0/oq6Exc+juzK6/BZS2GWMeyq
        /ZWLJzizVB3yuMFJSBPzmGsRp8BFqmkiP17JOdEtH3lq
X-Google-Smtp-Source: APXvYqykzjSK0A7nElMNFElazNkND86ZDIvpxzQ/em44P4JYuXvKWjoXtS+HZP0pK6EVN5Y479IuAUq6wZiqESVd+Eg=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr18032369ljg.103.1554756310830;
 Mon, 08 Apr 2019 13:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-16-fparent@baylibre.com>
In-Reply-To: <20190323211612.860-16-fparent@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 22:44:59 +0200
Message-ID: <CACRpkdZZ6-+MVdK4bOP4SHxQ8uQ8zENcir7DSteHy4g+B5uySQ@mail.gmail.com>
Subject: Re: [PATCH 15/24] dt-bindings: pinctrl: pinctrl-mt65xx: add support
 for MT8516
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>, jjian.zhou@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        stephane.leprovost@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Sat, Mar 23, 2019 at 10:17 PM Fabien Parent <fparent@baylibre.com> wrote:

> Add binding documentation of pinctrl-mt65xx for MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Patch applied with Rob's ACK.

Yours,
Linus Walleij
