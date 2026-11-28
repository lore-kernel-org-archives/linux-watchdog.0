Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795886773;
	b=F3hp+amQb1xtxx9Kh2zVLCJc/P/NDcbhrf3hVmoZCWRYMO78YFKONWjn06EqoQBY7IfF
	 g84TPtrZnskitDSEHFfkM02Xw3jD7hwyJYnCWfQoLo8WjH52zyr6VSzEQSPCB9b8Zoc+O
	 sgmx398fvhsw3AuOIqEvABJ9Z7K3UkoTHo00KVFlVG0usbyL5SbFpWqRmpqrPwJ61gWL5
	 eDqixWmTW/0Hzr1Lsc0QtyIHWTwzEXMtXdzq4W0Sm4+E/jaUvPU25m5aROh2TZAl+ZUWl
	 YuFHBAxLGXcuu2FcBvT8gtBNS4tBQ2jX95xs/GyfciAIvDS2JsJ67P5S6pCbA2PLkow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795886773;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=3eEC6+EEmYTZi1dMQk8GB0sNApEUcZVD5Huhxuj6g+4=;
	b=PU7fuYMtmT/0gSuGTo30zAARRE4CG5qwkvj679axz5NL6b9cZxhyXr3joPQS8aEXMxwc
	 DC+8F606LlJATwp78mwdDw2qF/nxGAIXHCy6untPOLtRjrghvClhbyWWfSxMmBNVpn1Ho
	 2UjRtvG422n9M8UbKqvEz2O2/t3yvjE0xBrQGtgGzIj4vs5e1lY91jiQxlltQkJszPbib
	 9wNk0BkxRtWvpP/NVx/F11aBn2YAnmfwSgh+0dckqK2xNGEuH+/PaohqOo8y6RLGnuYBA
	 7NsTpzSD+rE9GEymIoHe+rbrKCB/Fo65/gb/ygOe/hVDYVRyT+MTNoyV2+v4jsRJ+Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MACpk2tY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E1606A31C;
	Sat, 28 Nov 2026 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MACpk2tY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1CD1F0089A;
	Sat, 28 Nov 2026 17:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795886772;
	bh=3eEC6+EEmYTZi1dMQk8GB0sNApEUcZVD5Huhxuj6g+4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=MACpk2tY359Sm6A1qFAhOG5OC/RMT6P31h+6Jg7Z5nAlZmWRKZdP50VpjVbRSQEiY
	 DTEQUT6j9z6F9Lwm/GGf1JYzzdyhcdJJdP496KxUkUafAHl0LV7zeHRIbUYR/B2peK
	 MK3HUo4qZn3RX5lnYAIj8pViYm9YmwH2G1zcXI8llxRGd7vr051DBPXw614nXQpz90
	 wOCPINJWvLVyROdBAAMEpNxndcSD32GnD8qcXt6F5gAAa4eJww/q2aSUm5y6vDFslP
	 fLhPuTqfRVe/v4zWYAEEBU58wJwQHIxGanN/NCkZGb2e734suvPQybvDmwBHzN2r74
	 JSWKy5vX9l6Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 718E7392B1C5;
	Sat, 28 Nov 2026 17:26:12 +0000 (UTC)
Subject: Re: [GIT PULL] watchdog fixes for v7.4-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261128160200.988864-1-linux@roeck-us.net>
References: <20261128160200.988864-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261128160200.988864-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.4-rc5
X-PR-Tracked-Commit-Id: 4aa6ef16095644ecd8ece085384ea65543867dca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0768fa6b6413323037e33d670de9c3a65be318c
Message-Id: <179588677116.1993961.14109242719323502893.pr-tracker-bot@kernel.org>
Date: Sat, 28 Nov 2026 17:26:11 +0000
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

The pull request you sent on Sat, 28 Nov 2026 08:02:00 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0768fa6b6413323037e33d670de9c3a65be318c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
