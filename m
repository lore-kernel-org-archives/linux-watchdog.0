Return-Path: <SRS0=zfrQ=6E=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F4AC54FCC
	for <linux-watchdog@archiver.kernel.org>; Mon, 20 Apr 2020 23:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAC12145D
	for <linux-watchdog@archiver.kernel.org>; Mon, 20 Apr 2020 23:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDTXMK (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:12:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:54256 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDTXMK (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Apr 2020 19:12:10 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DCD94823;
        Mon, 20 Apr 2020 23:12:09 +0000 (UTC)
Date:   Mon, 20 Apr 2020 17:12:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Bumsik Kim <kbumsik@gmail.com>, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Bumsik Kim <k.bumsik@gmail.com>
Subject: Re: [PATCH] watchdog: clarify that stop() is optional
Message-ID: <20200420171208.3a2a5693@lwn.net>
In-Reply-To: <1fe9be6e-7da1-e738-c825-beddef31fd54@roeck-us.net>
References: <20200403031507.63487-1-k.bumsik@gmail.com>
        <1fe9be6e-7da1-e738-c825-beddef31fd54@roeck-us.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Thu, 2 Apr 2020 21:07:27 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 4/2/20 8:15 PM, Bumsik Kim wrote:
> > The commit d0684c8a9354 ("watchdog: Make stop function optional")
> > made stop function not mandatory, but the comments
> > and the doc weren't reflected. Fix it to clarify.
> > 
> > Signed-off-by: Bumsik Kim <k.bumsik@gmail.com>  
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied, thanks.

jon
