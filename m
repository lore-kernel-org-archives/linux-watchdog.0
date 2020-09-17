Return-Path: <SRS0=sx2n=C2=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696B5C43461
	for <linux-watchdog@archiver.kernel.org>; Thu, 17 Sep 2020 18:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1001C2072E
	for <linux-watchdog@archiver.kernel.org>; Thu, 17 Sep 2020 18:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600369176;
	bh=WK9WNOdBIC1c5pGjDrnuejewgkdOXuYSoT3lWCA1f7c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=LgYwi+jNYsYzAe6dFWcGvMcspUgQ6YmZPWZ93rI2+N9aMqiL4avjP3fAqQ4H7SZWH
	 6GNoa7OYXPJDR6F5wARJK7p+vggqtCaiyU3kllKyT/QicXb0Uazv6DxxgtWZzBYKEH
	 94xCGfyexgVBMQ6RD43m6gNkVmYZoeq/acm0Nfls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIQS71 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgIQS7W (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 17 Sep 2020 14:59:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 359C421973;
        Thu, 17 Sep 2020 18:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369141;
        bh=WK9WNOdBIC1c5pGjDrnuejewgkdOXuYSoT3lWCA1f7c=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=vjdoXXuDeQF84xqT6PeW33qsz+xL2agpPM7z0aXrH7txnFix+zgX+WWZto04x5I9M
         Wt3NTnamGk4xAHO5xpG3XwYhKUCLjfGGhcgTLv29FNWBGJf+yyO4WixqgqNQK5MctS
         /rAh/B8GGC6Ox42VMyvJoBC4/dD0iMbaBEiS1Bqs=
Date:   Thu, 17 Sep 2020 19:58:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     mazziesaccount@gmail.com,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, Guenter Roeck <linux@roeck-us.net>,
        devicetree@vger.kernel.org
In-Reply-To: <cover.1600329307.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1600329307.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v1 0/6] Support ROHM BD9576MUF and BD9573MUF PMICs
Message-Id: <160036909191.20316.7316711762331260496.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Thu, 17 Sep 2020 11:01:27 +0300, Matti Vaittinen wrote:
> Initial support for ROHM BD9576MUF and BD9573MUF PMICs.
> 
> These PMICs are primarily intended to be used to power the R-Car family
> processors. BD9576MUF includes some additional safety features the
> BD9573MUF does not have. This initial version of drivers does not
> utilize these features and for now the SW behaviour is identical.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt_bindings: regulator: Add ROHM BD9576MUF and BD9573MUF PMICs
      commit: fdb2f9ffc9f533ceef16666818557ea7b6edfe2a
[2/2] regulator: Support ROHM BD9576MUF and BD9573MUF
      commit: b014e9fae7e7de4329a7092ade4256982c5ce974

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
