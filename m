Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533054;
	b=YygwZQgdb9gfsT0aOn0rxjt6GaxhATaBSA7dyiDsN50gpBhRJjUEuYR0BbGQojK7t8c7
	 suEW9ZySKocs+mqrJewhDz4wtTd8ZZoiEupWXhAdKMMZStDw3s8ZcIvh95MrPrhjZospS
	 KSQMyqFr43ifzshr9C3niE0cG7nU9QWxmBHtuNzTRukQpI2U2RYDYYnUWasag8+714yD9
	 WUuo5nw7GVjmrx9AfB4Mcq1DXYnwzO6m1AMQt59BV1xnokP1BXj8ybD0rwsTGJ9MS/dBB
	 Y+MzAEwNEJDG1ahhM4GaB/jZUTreV3vk7MKPFzUisVfs6ONmY7tlvjAOajKk9T9THhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533054;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=x8UciKAmG7U28D+T0BB/FxXbIfUnkVtlC+pz9Z7I8JE=;
	b=DtnVScVyemYY6tqNNO5RyweopxM/5tQIwOdOAbEgCcU9MKg5twWXgtnhUN+O+wV/wZ4f
	 731Yo88aRyfyTNNcb2FJKGmYc/2j0PaLLsKs3tJEZCzpfvpIQfi4NS/ImRP5VBpbPCP3t
	 UP3ou9+Z1SQ+4Y79JFKuaJ0Y2K9468FPEzYLxO6ER0V3LvMgxkQaiK8y5otzUTRauDx3+
	 UCamYwUF+HbLEQpZ3IiOJnzWGk50wkh7uPxti2FbEs7S3dSmyNtgiWDmL98Nkn/8Oofjh
	 Bp7jv4zkqMH9OBAdOzmJo5Db8Qa4lPnO7OChMYjbaC7evEBmeKSH1uq96YRmx5IXxLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=dsQNvZ3S;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8245606A31E
	for <linux-watchdog@vger.kernel.org>; Tue, 24 Nov 2026 15:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8245606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=dsQNvZ3S
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id VqnAxNaCIOOJnVsAWxFcTl; Tue, 24 Nov 2026 15:10:52 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id VsADxyYVExqjjVsAExH6vC; Tue, 24 Nov 2026 15:10:34 +0000
X-Authority-Analysis: v=2.4 cv=bZxrUPPB c=1 sm=1 tr=0 ts=6b05a8fc
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=bttbqOl1rAlbph8SnnIA:9 a=CjuIK1q_8ugA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x8UciKAmG7U28D+T0BB/FxXbIfUnkVtlC+pz9Z7I8JE=; b=dsQNvZ3StQrnIav4+ZR6NHflo2
	pfDVq/qZLaEqJzYDLuZQ9euY6qsrhfA48uqqhzFsFG6RAQcSAtFl8wW+0P004hlfcnnZg6aar3/I+
	gQK3zf/GwqKbE7gsDgRr/T6eADIQvM5Ip6tgVa68gupASw5dRyrUJmFLWT+99lAiOPNaXjYnLPzol
	dLZuDABrCLrYwveHtTty1nTySGGR8OWfv9XlFW+jeqXs45a75fHNUSDd6+DIpcCgX9Qf3X3uCkEkP
	MeuS7tPsnsxwrZl1FwQj+TIPMIR0zFGtyqVdY0P6jp67RkzN+uLDSyqoRclVPucaZtxjz1uZhGP8B
	PpyWZgww==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43094 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xVsAD-00000001C1A-298I;
	Tue, 24 Nov 2026 20:40:33 +0530
Date: Tue, 24 Nov 2026 07:10:32 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH] watchdog: arm_twd: Protect the clock snapshot until
 notifier registration
Message-ID: <595b7a44-66f8-4e8f-bdb1-09aef25ab7b9@roeck-us.net>
References: <20261124-arm-twd-clock-notifier-v1-1-62933570ae27@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-arm-twd-clock-notifier-v1-1-62933570ae27@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xVsAD-00000001C1A-298I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:43094
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 10
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAj+lGuFd9iW6PtIzBi4up7S55/2tB44CEVHgD5pnu1qeIdihN2ps36i07H19LjpyzgdkP6yOeqpg74IvxBENLaRTmvvxywlKTSfpzz6K2TqnK05LoKi
 tiZT6dqfhIcqswlnptA7iwqSQFlFs3J18kTreitgG7G1xpsihX3TNp/dYY5PLJPeCrnK4QmK8wItgqO5sIxmqXJV3oyIDxPxC6fTynEIZWLWT2VoASbxaxf4

On Tue, Nov 24, 2026 at 12:21:59PM +0300, Fil Dunsky wrote:
> From: Fil Dunsky <filipp.dunsky@gmail.com>
> 
> A clock rate change can complete after clk_get_rate() returns but before
> probe registers the clock notifier. The driver then misses that change
> and keeps the old rate when programming the watchdog counter.
> 
> Take temporary rate exclusivity before reading the clock rate and release
> it after registering the notifier. This protects the snapshot against
> changes from other consumers, including changes to an ancestor clock,
> until subsequent transitions can be observed. Release the protection on
> the zero-rate and notifier registration error paths as well.
> 
> Fixes: 52d91ea73e05 ("watchdog: Add ARM TWD (MPCore private) watchdog driver")
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
> ---
> This is a single-fix follow-up against watchdog-next, rather than a new
> revision of the accepted driver series. A rate change from another CCF
> consumer can finish between the rate snapshot and notifier installation.
> Temporary rate exclusivity closes that handoff without retaining the CCF
> prepare lock or holding the watchdog mutex across a CCF call.
> 
> Validation: the old and fixed clock-backed probe branches, actual CCF
> functions and the actual TWD notifier were exercised with 25 deterministic
> interleaving/unwind cases under both GCC and Clang ASan/UBSan. The full
> modified driver also builds as an ARM module with W=1, with all imports
> resolved. These are offline checks; no changing-clock hardware test is
> claimed. The separate maximum-timeout policy for future faster clock
> rates is unchanged.

Squashed into original patch.

Thanks,
Guenter
