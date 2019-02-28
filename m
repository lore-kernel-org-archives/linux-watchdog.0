Return-Path: <SRS0=C3hG=RD=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33FEC43381
	for <linux-watchdog@archiver.kernel.org>; Thu, 28 Feb 2019 23:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9448020C01
	for <linux-watchdog@archiver.kernel.org>; Thu, 28 Feb 2019 23:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfB1Xo4 (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:44:56 -0500
Received: from smtp1.linuxfoundation.org ([140.211.169.13]:58256 "EHLO
        smtp1.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbfB1Xoz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Feb 2019 18:44:55 -0500
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Feb 2019 18:44:55 EST
Received: from rt.cvo.linuxfoundation.org (rt.cvo.linuxfoundation.org [172.17.192.131])
        by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 12BB171C;
        Thu, 28 Feb 2019 23:37:40 +0000 (UTC)
Received: by rt.cvo.linuxfoundation.org (Postfix, from userid 48)
        id 0C4F4492; Thu, 28 Feb 2019 23:37:40 +0000 (UTC)
Subject: [Kernel.org Helpdesk #69024] patchwork support for linux-watchdog@vger.kernel.org
From:   "Konstantin Ryabitsev via RT" 
        <kernel-helpdesk@rt.linuxfoundation.org>
Reply-To: kernel-helpdesk@rt.linuxfoundation.org
In-Reply-To: <4ae83727-d89e-5201-00bc-347b3a8cea0a@roeck-us.net>
References: <RT-Ticket-69024@linuxfoundation>
 <4ae83727-d89e-5201-00bc-347b3a8cea0a@roeck-us.net>
Message-ID: <rt-4.4.0-17515-1551397059-1845.69024-6-0@linuxfoundation>
X-RT-Loop-Prevention: linuxfoundation.org
X-RT-Ticket: linuxfoundation.org #69024
X-Managed-BY: RT 4.4.0 (http://www.bestpractical.com/rt/)
X-RT-Originator: konstantin@linuxfoundation.org
To:     linux@roeck-us.net
CC:     linux-watchdog@vger.kernel.org, wim@iguana.be
Content-Type: text/plain; charset="utf-8"
X-RT-Original-Encoding: utf-8
Date:   Thu, 28 Feb 2019 18:37:40 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 2019-02-23 11:59:29, linux@roeck-us.net wrote:
> Hi,
> 
> would it be possible to add support for linux-watchdog@vger.kernel.org
> to patchwork.kernel.org, with me (and possibly wim@iguana.be if he has
> an account) as maintainer(s) ? My patchwork account username is groeck.

Would you need patchwork-bot integration? Please see here for details:
https://korg.wiki.kernel.org/userdoc/patchwork#adding_patchwork-bot_integration

Regards,
-- 
Konstantin Ryabitsev

