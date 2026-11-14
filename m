Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674972;
	b=T4xZ2A0JkFecJmAPInobUB0KdB3IGOLEqH41t2VVsspJp2ved2IN7QX+uWirkfRFlG/l
	 iUU3nhezF1nilRQrit9pKMeR4bCxBn5VjpwzRdqLRw0ikAvDkwf1vkWT4ICvgGyy3PdpK
	 /oxxcb7kxR+shNIcwmODSuWgSDpClLRLj7IsrFxmc5KSBVxYqkN7q1Pl8GifLtmGaABYk
	 DoCFJEgPWz+2oqOKZ7Y7PZj6VTSkv59Wi13Tu7UqmQ20tt1i+aHk6v/pU84d7lswfQcJD
	 GraFtz4HORRg6G+GUMdibr9riyQUxCzs0Xs1uOqaMQn2SM9R9DYqSze8fsDgjpW5vsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674972;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=OoGesPiX85Tva2TTyVlLNeL9LBKzZ9uijhCj1wHQqnM=;
	b=4giqQNAhJicOkfcPcCXABMn/kpW9FkiHaFmleMfXwNv72/1xiGJ2QOIqsVmfLAOEiHK9
	 iMm8acgjEy0OgmFVpigZqbl/STc876891OPbLS5xwp2cHdfxa12ci1lfzDB5BKsCzrn3E
	 S6Y9AHkWlZF8HSOGBtV4dHTjjh3VFDMBhq72zzxcC94o2i4cs8HDAASM0Li9N8q165i8y
	 fpPzLgSXz1j+LwqK78MtZBrEz39dt1nU9OnRSuERkPLFdz8xe5TSM0pgRrD+t931SFNYF
	 zf73rbWSg9lW0a2TWoy2Q1oFZrnLDOxU8NeFGpPDcfTRmIHl+T40PCO4m2lqSQLb7GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecpLoxr7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0159606A323;
	Sat, 14 Nov 2026 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecpLoxr7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBB81F000C4;
	Sat, 14 Nov 2026 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674971;
	bh=OoGesPiX85Tva2TTyVlLNeL9LBKzZ9uijhCj1wHQqnM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ecpLoxr74W6q4V19oejer+2YLEoEWLp4/PMr5SadcCcRKRsbXzEcCTvQVarWSweLD
	 rTT6leIctJ4yHisYXUG5/ibjb8w4vC9F7CqSNJMlIUPbSaCeZKE/LHGvfCjhtn4SiE
	 34NzWG95VHWVr+YV7vEpDEVYgVLLuXuj+8eW2lFpn1r0xBjwKqtftGcK8JGvJSgKw1
	 BoyBgWPFyBWsYpL3Jd3PGOE1LvM2zXSYv4l48qdt4qvClrzcs3k6+kDfxrZML+O6QQ
	 L+IClkzy8U5qQWojPaHvYCw6JwYwu2pLjSCTa0h4BBbN00Wp0OrSAfA03w23TJMk58
	 to4KTEuQrJXww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44C3380821F;
	Sat, 14 Nov 2026 16:49:31 +0000 (UTC)
Subject: Re: [GIT PULL] watchdog fixes for v7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261113200720.2752960-1-linux@roeck-us.net>
References: <20261113200720.2752960-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261113200720.2752960-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-fixes-for-v7.4-rc3
X-PR-Tracked-Commit-Id: f00afd5d8d5dc03994cb67246543d5c70571ebbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0716b41b472ed6ec9c9c9bae1f8836eadd149f95
Message-Id: <179467497032.2233204.5551575827529704490.pr-tracker-bot@kernel.org>
Date: Sat, 14 Nov 2026 16:49:30 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 13 Nov 2026 12:07:20 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-fixes-for-v7.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0716b41b472ed6ec9c9c9bae1f8836eadd149f95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
