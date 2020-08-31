Return-Path: <SRS0=1S4C=CJ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D9C433E6
	for <linux-watchdog@archiver.kernel.org>; Mon, 31 Aug 2020 05:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31EF20936
	for <linux-watchdog@archiver.kernel.org>; Mon, 31 Aug 2020 05:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598853217;
	bh=Vy0Nz0qiaESRdy7iweD0uCI8E+pZVYudRgy8ZRE+JI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hqm+yf82Y8Xv8hOenxKKnWD0EKBaW9M/KoI7uevtVWOXjewRtAqvaQ4C3xFJpv25T
	 Fq9atii74uScM93V0TMbP+PPxTRWnGSyxLglZDEWgr+5C7c5vR1XMkZAteD6m1BvIr
	 /fahcTO2v14sR8/S4XoCj4QttHWdhu1mc7HZiAVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgHaFxd (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 31 Aug 2020 01:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaFxd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 31 Aug 2020 01:53:33 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3997020719;
        Mon, 31 Aug 2020 05:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598853212;
        bh=Vy0Nz0qiaESRdy7iweD0uCI8E+pZVYudRgy8ZRE+JI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vt7KT8TleUnDiZNq6raLUbyYax27tcht4uS8FNYACEuMWSmxQc+NJV9ltWqmC6A69
         gdjeV2k4lAj8VDx/emasnHg0QLd2cQlsUOLrqwF1olQmgHXvMvy9TaJ1u31LP7TYFH
         n+OvoCDFii+DE4n1YTL1qAxdoEUTp34WasSn40ik=
Date:   Mon, 31 Aug 2020 13:53:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Viresh Kumar <vireshk@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 04/10] arm64: dts: freescale: Fix SP805 clock-names
Message-ID: <20200831055326.GL4488@dragon>
References: <20200828130602.42203-1-andre.przywara@arm.com>
 <20200828130602.42203-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828130602.42203-5-andre.przywara@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Fri, Aug 28, 2020 at 02:05:56PM +0100, Andre Przywara wrote:
> The SP805 binding sets the order of the clock-names to be: "wdog_clk",
> "apb_pclk" (in exactly that order).
> 
> Change the order in the DTs for Freescale platforms to match that. The
> two clocks given in all nodes are actually the same, so that does not
> change any behaviour.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Applied, thanks.
