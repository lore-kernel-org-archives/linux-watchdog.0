Return-Path: <SRS0=wErF=D4=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0176C4363A
	for <linux-watchdog@archiver.kernel.org>; Wed, 21 Oct 2020 18:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D0021531
	for <linux-watchdog@archiver.kernel.org>; Wed, 21 Oct 2020 18:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603305321;
	bh=WwdA8A+GA62TbjEC6GGhJ1bNaPeO2v7d03rwL41tSiw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FYYpIglMfJ9mlbCzZSQKZnRRZaZsWHo/wHaqezcMgzi7tOrXJ2h9ty+yKH+wUTeL3
	 juDCKzwnt+cl8fANnZkZdM/kNQQ/LOf87W+05ZygBl4ZftyrluKosg1YlYQFgiCwFr
	 wnsjxO/8OzoM5NrrRUlmDsGM1sAo7MAaEuzZHG58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504218AbgJUSfU (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410451AbgJUSfP (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Oct 2020 14:35:15 -0400
Subject: Re: [GIT PULL REQUEST] watchdog - v5.10 Merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603305314;
        bh=WwdA8A+GA62TbjEC6GGhJ1bNaPeO2v7d03rwL41tSiw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yYSONiK3Gw5YAGk00MSqNx1f/3qcav60QjHro6LR1k3/MdWvJmF6cdIewj+0J76f/
         VnXp9YrtJUTVl5yNeihFf1qlZuDeWkkUbwI4FtbndsRUMFc4jsxWoRWf8Dabi4qlN+
         jY557xqGOqsBhBf5xWq2Q6BzlBWqB6RZ45PVtk3w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201021125411.GA12717@www.linux-watchdog.org>
References: <20201021125411.GA12717@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201021125411.GA12717@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.10-rc1
X-PR-Tracked-Commit-Id: c5b8e4644607b0319fd86a36fb0caad54ee2021e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f804b3159482eedbb4250b1e9248c308fb63b805
Message-Id: <160330531489.16606.13638360771993162462.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Oct 2020 18:35:14 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anson Huang <Anson.Huang@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Hanspeter Portner <dev@open-music-kontrollers.ch>,
        Hanspeter Portner <hanspeter.portner@livesystems.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The pull request you sent on Wed, 21 Oct 2020 14:54:11 +0200:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f804b3159482eedbb4250b1e9248c308fb63b805

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
