Return-Path: <SRS0=D8aP=AT=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC20C433E0
	for <linux-watchdog@archiver.kernel.org>; Wed,  8 Jul 2020 18:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723742078D
	for <linux-watchdog@archiver.kernel.org>; Wed,  8 Jul 2020 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594231937;
	bh=NMBUlEAkc7RpyfeAxKbI29XUZhY7DFLePH+AnYgXlKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M2sm5+HehKeeNLXX3ajQnzb5rrPu33B0o3lIlujKjRNfjHZDvlpXAMqtD8XSZnr/V
	 6ImuGj9/TPiHgmM4SdTFK4NyAhfTo7Z3+yBsU28xsTqXwus/mHCFqisfLdZLtMs3HB
	 xKKTXRto5NaO2Fp9ZNiUssbv9ePKE8VoppykPwlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgGHSMR (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgGHSMR (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 8 Jul 2020 14:12:17 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A27B3206F6;
        Wed,  8 Jul 2020 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594231936;
        bh=NMBUlEAkc7RpyfeAxKbI29XUZhY7DFLePH+AnYgXlKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wn/nR8pZ5vP0s9K/zSgdMdH3N5/y4LDUHyeohyMtmcsRTFOIcsAzqHwvLgq/nbTNG
         8AhdLUIQJ6WRb7ywnfppHXzSkcNN99u/QT4gZHMqD+g1AkDV8WAtYiHOp/bsQV7592
         zTvF6O6ty2msPOePUB0rlPBXqBEhPDx00XQjF+60=
Date:   Wed, 8 Jul 2020 13:17:46 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: Use fallthrough pseudo-keyword
Message-ID: <20200708181746.GC11533@embeddedor>
References: <20200707171121.GA13472@embeddedor>
 <385b949a-34d0-acd7-ef86-4801a27b75e8@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385b949a-34d0-acd7-ef86-4801a27b75e8@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Tue, Jul 07, 2020 at 06:39:24PM -0700, Guenter Roeck wrote:
> On 7/7/20 10:11 AM, Gustavo A. R. Silva wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 

Thanks, Guenter.

--
Gustavo
