Return-Path: <SRS0=VqY2=CG=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF18C433E2
	for <linux-watchdog@archiver.kernel.org>; Fri, 28 Aug 2020 21:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECCD207DF
	for <linux-watchdog@archiver.kernel.org>; Fri, 28 Aug 2020 21:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598650137;
	bh=rpIzo7G9UZBTkcxiVFy0Lzx+94REmDCnv4s1vxWhhGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pLi7hjimGg8H7gsvVBR23DgN64X5GQ/IXvEx/IZq6CbUICte5cPKkVDJJhXS4I+HH
	 t/nzjE1DzWGFuTDsLhJbxENJDmnLG/0k02CK2j9t21/uuqS4g8NpDE3PWT4s/j4fqE
	 tmfnmHjS5tyEM1HeTAq0x03+ywceRWINab3i1AcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgH1V2x (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Fri, 28 Aug 2020 17:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgH1V2x (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 28 Aug 2020 17:28:53 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931072098B;
        Fri, 28 Aug 2020 21:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598650132;
        bh=rpIzo7G9UZBTkcxiVFy0Lzx+94REmDCnv4s1vxWhhGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o0rdHkxrgG2ttKyfE76iKsdAIbNcYsTv3SdalC/0gcKlUTpRbxqvWU59mUozV7BnE
         gpZrH6d7fMZL/RH62GoNvqzN0tO+G4VUGjIiI//J4LWopv1S1gTuqgKNA5NAXFAdWZ
         /lRW/D5jcjdR/GUVhnlfJirA0z6DxZcs3RBpsz9U=
Received: by mail-ot1-f42.google.com with SMTP id k20so478068otr.1;
        Fri, 28 Aug 2020 14:28:52 -0700 (PDT)
X-Gm-Message-State: AOAM531+FW2XNOCfxS44s61n7pDSxfBs2gfFoIIXxKWqkE5nYHjlIEHV
        ScljbDpDkWG4+out58M0zUZbwU/7x2uOBe4fqA==
X-Google-Smtp-Source: ABdhPJyhZma1htiqBCnZWu9fBkKp+z8GjxtNVqs55zAakywBxE0Jss6GAQ+/xSXgVBWoWixlxmG5ccrepr4X36NqBpo=
X-Received: by 2002:a9d:32e5:: with SMTP id u92mr405224otb.107.1598650131822;
 Fri, 28 Aug 2020 14:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200828130602.42203-1-andre.przywara@arm.com> <19c6a67e-48f0-c0b6-3653-32a5a1f09e07@gmail.com>
In-Reply-To: <19c6a67e-48f0-c0b6-3653-32a5a1f09e07@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Aug 2020 15:28:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKvcGAotS6xL7pu+wM8X33PLCQCuoaXYmWrA3j3OdoR5A@mail.gmail.com>
Message-ID: <CAL_JsqKvcGAotS6xL7pu+wM8X33PLCQCuoaXYmWrA3j3OdoR5A@mail.gmail.com>
Subject: Re: [PATCH 00/10] dt-bindings: Convert SP805 to Json-schema (and fix users)
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Viresh Kumar <vireshk@kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Fri, Aug 28, 2020 at 1:34 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 8/28/20 6:05 AM, Andre Przywara wrote:
> > This is an attempt to convert the SP805 watchdog DT binding to yaml.
> > This is done in the first patch, the remaining nine fix some DT users.
> >
> > I couldn't test any of those DT files on actual machines, but tried
> > to make the changes in a way that would be transparent to at least the
> > Linux driver. The only other SP805 DT user I could find is U-Boot, which
> > seems to only use a very minimal subset of the binding (just the first
> > clock).
> > I only tried to fix those DTs that were easily and reliably fixable.
> > AFAICT, a missing primecell compatible string, for instance, would
> > prevent the Linux driver from probing the device at all, so I didn't
> > dare to touch those DTs at all. Missing clocks are equally fatal.
>
> What is the plan for merging this series? Should Rob pick up all changes
> or since those are non critical changes, should we just leave it to the
> SoC maintainers to pick up the changes in their tree?

I don't take .dts files. Either subarch maintainers can pick up
individual patches or send a PR to SoC maintainers.

Rob
