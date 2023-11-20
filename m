Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1E0C2BB3F
	for <linux-watchdog@archiver.kernel.org>; Mon, 20 Nov 2023 17:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjKTRd5 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 20 Nov 2023 12:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKTRd4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Nov 2023 12:33:56 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D8B10C;
        Mon, 20 Nov 2023 09:33:51 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r589X-0008RA-0O;
        Mon, 20 Nov 2023 17:33:44 +0000
Date:   Mon, 20 Nov 2023 17:33:41 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 2/2] watchdog: mediatek: mt7988: add wdt support
Message-ID: <ZVuYdZQbwj4tAfER@makrotopia.org>
References: <4d7db8786dce35273db516f3d41228bc27a08fe9.1699980962.git.daniel@makrotopia.org>
 <3f5ed9656ea66637d259e9771ed852511369ba9b.1699980962.git.daniel@makrotopia.org>
 <dd9c2e72-c0dd-4e94-9474-a20b4598a0d4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd9c2e72-c0dd-4e94-9474-a20b4598a0d4@roeck-us.net>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Mon, Nov 20, 2023 at 09:19:46AM -0800, Guenter Roeck wrote:
> On 11/14/23 09:04, Daniel Golle wrote:
> > [...]
> > @@ -89,6 +93,11 @@ static const struct mtk_wdt_data mt7986_data = {
> >   	.toprgu_sw_rst_num = MT7986_TOPRGU_SW_RST_NUM,
> >   };
> > +static const struct mtk_wdt_data mt7988_data = {
> > +	.toprgu_sw_rst_num = 24,
> 
> Kind of odd to have this defined locally, while the others are in include files,
> but not worth arguing about.

From I have just learned from Krzysztof Kozlowski those headers shouldn't
even exist in first place, as the listed IDs are not actually referenced
anywhere in the driver, hence they aren't actually bindings [1].

Quote from that thread:
| >>> Where is the driver change using these IDs?
| >> It isn't needed as the driver doesn't list the IDs. [...]
| > Then it is not a binding.
---

Now that they do exist it's too late to change that for everything
already existing, I suppose. However, it also doesn't seem like adding
such a header for MT7988 as well is going to be acknowledged, hence we
will have to live with the inconsistency in the driver in which older
SoCs will obtain the number of resets from a macro in their respective
dt-bindings header while newer SoCs won't have such header and hence
it will have to be defined in the driver itself (as that's also the
only place where that number is being used).

> Please make it a define at the top of the file, though.

Ack. Will do.


[1]: https://lore.kernel.org/lkml/6912f6f406bc45674020681184f3eeca2f2cb63f.1699576174.git.daniel@makrotopia.org/T/#ef01d7efc6c4fbf1d4830bafe7c90e39746939671
