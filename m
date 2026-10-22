Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694339;
	b=PRibr4eS6EuRlgSy6ZsT+0s33INCJn2IJ3ZwzH4Mv6Xc1gs4bf+29IiIkSKj2DEJyPBe
	 na2+ip+QW5+DoUkpbRV+vYOnN0IFVetoVDCekvUvDYFkxxwdDBzmoHeP50Bcz40lRm4Ph
	 R1xKI1wXnSbNfLjJ0ThGsC+S8z06xCPk4MNBopfImLLcFf5qYImgIMNhcd/Pq1MyY/2UG
	 eQpeOEENezVPelrEbyHFhWqjWurcQkTyio6AKRLyOs3/uweWJvz4IhMg9zoQr2eIUGA4H
	 f9ErGDk4RXhA3yZJGb2xQZkoN5UtxZyQoyh/TYRvYDZ0DmPd/5htM+CQ+pT+/uyaGUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694339;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=YAe86aBBQdytmxkGOs9dvMgl1RnGRJYI44LXpdLI96A=;
	b=mGdftadpL8ChQrBOYE9ZwyjobH/jOsgsvepsZ/NC6Fz2PEA6ZzgXdWbU3NWKWVSgPNeJ
	 6LaXZ1WUe01i3Aa9M9R1hJuTapJJOzwuCDDt4kdmB4kKOtKoTKV8cXQzc+652JXwf2NRx
	 C73/WV1A+T6Pzk5ih/fuaOgH6Sswii9jF/S3QrXd55l8yMe2KKr2yPxz5S8qQztc0xvUK
	 OQgcQ64JiGW2c2chgKmlOULaJJwYXoxPVOnuKrprL/rKJ6JSROGUn8cLYIXioZ1mjWxlO
	 lrY2iQdldPI+UaXYi1xwkc5/UlxOYUIR3NuoQqy9BQ+BDHBVKakgYMjpjGCZ19gwYsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ep92A8qM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E409606B405;
	Thu, 22 Oct 2026 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ep92A8qM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0C51F01825;
	Thu, 22 Oct 2026 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694339;
	bh=YAe86aBBQdytmxkGOs9dvMgl1RnGRJYI44LXpdLI96A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ep92A8qMrJdPhonC/L+2dxgApCPM/wHAly4Etw9xI4vKyaSWv1srXcugD4unJykoP
	 tDORK9x3wE20YfmuZGtH8/uzTWcWS9qiYL9Q84u+hRaqSvbFucVXIu/Fnd+O+C49lN
	 gI5HfY3AOjVsfdcqn04sr/FYFlKHj033thvloVBuFQnneM1d5AsIftJGgcO78J+nAD
	 NV2HW8z5nmYIGVMTTxBVRy+4PUwHerE9Evbbr0r5S4YnZ1vf3GS4EjSXiZ0BmEv+OE
	 BHsQ8uqo3Ih6NTWApDVn/QWyZF5lLvRlpbEJAYb0cYnf9/XXMMLbl9Bx0PYb+CySzb
	 yO3PHsoS1TvOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4456D3808222;
	Thu, 22 Oct 2026 18:38:59 +0000 (UTC)
Subject: Re: [GIT PULL] watchdog updates for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261020005443.555576-1-linux@roeck-us.net>
References: <20261020005443.555576-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261020005443.555576-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.4
X-PR-Tracked-Commit-Id: 6276c8195e598361942082423114877265c17692
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22cbcdafe135752082853355168460c730d1c4aa
Message-Id: <179269433786.110555.6688866268206482343.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 18:38:57 +0000
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

The pull request you sent on Mon, 19 Oct 2026 17:54:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22cbcdafe135752082853355168460c730d1c4aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
