Return-Path: <SRS0=9Mj9=X4=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D730C32792
	for <linux-watchdog@archiver.kernel.org>; Thu,  3 Oct 2019 09:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C448218DE
	for <linux-watchdog@archiver.kernel.org>; Thu,  3 Oct 2019 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570094061;
	bh=AjvL547s2R5yIkHNhXlH94XxA05nAjKAg5dQITv7FQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KpHFIqgAixIsIMp9BUmZeyUTfYWPeZcL/JTw5inw5tf7RkH4zbcqMtznMGGuPDEpG
	 jDcSLIV0yw3N0SLvIjQaW9sVaqXJSoK37KxGfLK7492QVfw+cTBIB4rXTDIL6SQ7YC
	 mOsmsHcMPhqFXOqewZQXequxTnPoQpL3fyGNTjUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfJCJOU (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbfJCJOU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 3 Oct 2019 05:14:20 -0400
Received: from X250 (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D16B4217D7;
        Thu,  3 Oct 2019 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570094059;
        bh=AjvL547s2R5yIkHNhXlH94XxA05nAjKAg5dQITv7FQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUWGqSGrL6NfqsYQsqvHzb2riBwD1kzyTwoLkAgsQO1jRi/iIZR41+vjc3C7ue4zT
         o+4lokbcwcn6bvuSzCrXXojY24Ecbls74CAN5Nmmqt4hQXwvyyU+yT6t0pexmi48pp
         /HFF8mnqgjkkV9lbfj63tB+6nU9AOyNp7/K2yjVM=
Date:   Thu, 3 Oct 2019 17:13:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux@armlinux.org.uk,
        otavio@ossystems.com.br, leonard.crestez@nxp.com,
        u.kleine-koenig@pengutronix.de, schnitzeltony@gmail.com,
        jan.tuerk@emtrion.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V5 4/4] ARM: dts: imx7ulp: Add wdog1 node
Message-ID: <20191003091356.GA24782@X250>
References: <1566999303-18795-1-git-send-email-Anson.Huang@nxp.com>
 <1566999303-18795-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566999303-18795-4-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, Aug 28, 2019 at 09:35:03AM -0400, Anson Huang wrote:
> Add wdog1 node to support watchdog driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
