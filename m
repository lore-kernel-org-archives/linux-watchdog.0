Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871EECE79AE
	for <linux-watchdog@archiver.kernel.org>; Wed, 20 Sep 2023 02:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjITCKJ (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 19 Sep 2023 22:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjITCKJ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 19 Sep 2023 22:10:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D455C9;
        Tue, 19 Sep 2023 19:10:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19B7C433CA;
        Wed, 20 Sep 2023 02:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695175803;
        bh=4rabWQq0UehfRLcnAMiQFlo+pshDNKHLYhkK16tm71w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTLdcguwqIFEmQdhfJrP7kU7XsjPULjQNUlTPxJglY+gKzecy2dyExJ1/y15eAoHP
         wvbdpyHYE7x/FwP2/oCooXw/xUeKVXDq8Gw90vTvGNHQtqWtRP4+vi2LjmW+2PFp40
         l2yDyCtRhhZZtUgL9yzk6b/oMVZjonra/5dYJDo31df6DzozyfVAd7GkBG1SraJ+q1
         uUetlyXcXwVBJpBzKJa79Z4sJNe/woh8v1tAcwh/IPHfrFA0B03Ke1spNz7myjDzpg
         ca2hKtZJ/mZZK4DBj6HDqBj4ACjUGpCOJI/DXHHubsuONJESJOwtI/XdS9gYCTLpaC
         QjKBFXWer1Ztw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_saipraka@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: watchdog: qcom-wdt: document IPQ5018
Date:   Tue, 19 Sep 2023 19:14:02 -0700
Message-ID: <169517603990.822793.6632260895287617003.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230816161455.3310629-1-robimarko@gmail.com>
References: <20230816161455.3310629-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org


On Wed, 16 Aug 2023 18:13:59 +0200, Robert Marko wrote:
> Document the IPQ5018 watchdog compatible.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: ipq5018: add WDT
      commit: 9cbaee8379e620f82112002f973adde19679df31

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
