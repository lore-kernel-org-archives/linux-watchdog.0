Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795881730;
	b=bdnb5XAfG8wiPKIiVhO6CddqO+X3r0B1g+io05YLtZuHMZJ9Kq+jLVPGTjtRaD4jTMRA
	 0XNsMnQMB5o/qHOqaGqC6VI0cEuqzu0jRVliwxkUFEz+WWupwzyWA/QOvACiglD5gKPAT
	 oiDaYjL7fRExTPg6KIynSm4ynkYdokLdUZf1HYy9viTlBTbnWu1dpim7vdUMNypvyuKQy
	 1EvThk0xO7UNjGGsr/W8PBjofnzdXfGjPxPmAM0NjTSBgExmnTKw0phV5NiRRMoU7XnFO
	 Xm0BxuYntrHWi+p7EX6J0R5AccK63tTI6yX97zhOgJ5cMwTh/zdwD6BPdslCAOpXu8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795881730;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=D7mhCQGAXsJxHlhUIFdNYQH08H9wjkgkdnyW3xCag88=;
	b=4vN0tKBEfewbD6BSWswjoQLjapAZQPXJziSjSGzGhoCIhjw2RojVthrqASHs0gMtf45U
	 Hn/dJ7mAF2WrNPKtdFp7JEqTZ427bSaGTpLgQFweM4XFwVjZYSeaeyTKmf7nJi7BCGsg6
	 iOqSYop54oVR1Wgt09uHBDtOeWyomo/XJAz5uOkOrZZUOcEZm5vsaALu0e1f+cmfyAvze
	 EdRAAKQzmdKKTofCrLM4Aa5Z02B/tmqDkcVBXrWnL1XNM4BkKyrp/ILdgewZfuWXdf2Ob
	 DL2CM5OOBVZV6z1NEyYxjsFA267aUpvlmybmk7w5egvxOE8OUkCda7QfbPJUxLa/BZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=pT16GHIm;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6904606A31C
	for <linux-watchdog@vger.kernel.org>; Sat, 28 Nov 2026 16:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6904606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=pT16GHIm
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id WzIpxfeL0yb4YXKsFxaTp3; Sat, 28 Nov 2026 16:02:03 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id XKsDxoKzvxqjjXKsExopT4; Sat, 28 Nov 2026 16:02:02 +0000
X-Authority-Analysis: v=2.4 cv=bZxrUPPB c=1 sm=1 tr=0 ts=6b0afafb
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8 a=ehiMHvdStT9DuECwCHUA:9
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D7mhCQGAXsJxHlhUIFdNYQH08H9wjkgkdnyW3xCag88=; b=pT16GHImOL/2gx4zzPvV0LZSSB
	aLW+20WXWownCnS8IXMRBr237EqGk+y7Q9/z/xXDWIE3xCRjA8AYJOKWCNuaa3HWvy4rWb0m9ntTq
	28ExAV88AtVaoEJFXayOszPrUzgwnzGHdl4MbCQ7PiDheaSQ/8mADpipz6q0PGw8LhZpBnW1ZkaOQ
	w46BMc/B+02U8zPW+RDOzQckvbarCmYQsbNYjx8cKYjkavKz4o93PCR4DE9qyhjC0p1i7UziLLYkZ
	MRH59hssKjHHvet00fgCMCEfAnv072CcPqmR9pPFDq/j8wk+Zn5X0j1SoaI8N0bo1W0v00qg8DMal
	gdmAbSXA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40634 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.2)
	(envelope-from <linux@roeck-us.net>)
	id 1xXKsD-00000003ozm-2zn7;
	Sat, 28 Nov 2026 21:32:01 +0530
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] watchdog fixes for v7.4-rc5
Date: Sat, 28 Nov 2026 08:02:00 -0800
Message-ID: <20261128160200.988864-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xXKsD-00000003ozm-2zn7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:40634
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIuaLiWRn4cvfeufyukPDl2pmhmBzqmKyqzhltEFX5i7oZ36wIom+jgI8Bg6TbeJvF57fUqc3XZGwLn5lNGPtdTqYtZ0hxJqSB4fNiKVTIxUhd+lPup7
 uGsx6ub7zRP7jAJn9IFCy5OlJe12SSz82LhD7a/ExZQbZwTAKdT2KWpxQmyGN+CgdaESCW7QX7KryGaP8gwx+9yS2m2zQC2hBY9z24Ld+PKMNknxIuaNCOkw

Hi Linus,

Please pull watchdog fixes for Linux v7.4-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.4-rc5

Thanks,
Guenter
------

The following changes since commit b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f:

  Linux 7.4-rc4 (2026-11-22 14:57:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-v7.4-rc5

for you to fetch changes up to 4aa6ef16095644ecd8ece085384ea65543867dca:

  dt-bindings: watchdog: arm,sp805: reference the PrimeCell binding (2026-11-28 02:44:27 -0800)

----------------------------------------------------------------
watchdog fixes for v7.4-rc5

* core: return 0 from watchdog_get_timeleft() when neither WDOG_ACTIVE
  nor WDOG_HW_RUNNING is set instead of calling ->get_timeleft(),
  avoiding hardware accesses on stopped watchdogs (such as external
  aborts in omap_wdt via sysfs timeleft or WDIOC_GETTIMELEFT).

* intel_oc_wdt: add noirq suspend/resume callbacks to stop a running,
  unlocked watchdog during system sleep (including firmware-started
  watchdogs) so it does not reset the machine in suspend-to-idle, and
  restore the configured timeout and restart it on resume.

* sp805: keep the clock prepared from probe and call clk_enable() in
  the atomic restart handler so reboot still works after the watchdog
  has been stopped and its clock disabled.

* dt-bindings: reference /schemas/arm/primecell.yaml# in arm,sp805.yaml
  so arm,primecell-periphid passes DT schema validation.

----------------------------------------------------------------
David Yang (2):
      watchdog: sp805: re-enable the clock in the restart handler
      dt-bindings: watchdog: arm,sp805: reference the PrimeCell binding

Nhat Tran (1):
      watchdog: core: Don't report time left for a stopped watchdog

Paul Menzel (1):
      watchdog: intel_oc_wdt: Stop the watchdog during system sleep

 .../devicetree/bindings/watchdog/arm,sp805.yaml    |  1 +
 drivers/watchdog/intel_oc_wdt.c                    | 52 ++++++++++++++++++++++
 drivers/watchdog/sp805_wdt.c                       | 17 +++++--
 drivers/watchdog/watchdog_dev.c                    |  3 ++
 4 files changed, 70 insertions(+), 3 deletions(-)
