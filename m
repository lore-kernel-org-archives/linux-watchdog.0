Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14574A3410;
	Wed, 19 Aug 2026 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160128; cv=none; b=stWkqvkFi4kDSK1QUNT40+m1SI/TRlG/xdZSrJOAqV68FoRTir1L95froI0Hy7loykP0xI3Ctgyy7rSUxI1A1qhXSHHBcbxKwOwvo93wZsWmGduBcE2vP0xb/L3vq0Njs/DgZENRF1pTUvs7e+jgZL6pTF+j/lg0exrtbAPelKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160128; c=relaxed/simple;
	bh=l+Dr1HsjEg0TVAXBNyZo054IObDHOJYgSJyW9s77cnw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PH+VtvnF+1BWU+6V3UFsXjDnplvnQKWKOFjoXzKa9ALEF8bcSfgSnrp60C+9+BIb0hKa0VgiKaPfzqDddzVDpXvCFue5uzzuW+VLMJz+qSCshjR+gwU+fGHSohX/ur4PfCtHESN7bGRAe96dhsAdk8hvKLduSuMMkhI2sDuZwf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7EG8rss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7EG8rss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654EF1F33C52;
	Wed, 19 Aug 2026 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787160104;
	bh=vHUVXDfc8QMXlussqMRrh7YC3JGsu5QAItBMhOUqMTI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=n7EG8rssuS40t54/b7nYd9cbrqSc/sFXiWNtU3O0nBNCFIQGJnSznPNAdssXJI3Rf
	 hBYQCtdzpLlYqk1HcFZ79Dyo+qUGhd3yGdCCYrSs9Lo2r3n9xUjNwssXia0G8oiUm4
	 C3WbDP78Mzfz8P7sBIZN7pYAcX3AoHKBMYywBg+EFgSow97/7Ji4B+2SRCs1L3BpMs
	 7a06vFEkhbKS+WLaaWAp35k1TPPXRVwo92O38W5EBBeHLjtIBxNV1Mj1wSqzupOjIB
	 Is1h4zi2xmk7sZdDqGl5lyAk4U5uYJspCzUTlvFQsnZiVGeLLwBfnmwcLfCfqEhUt0
	 Ux/jSnXqVkXMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9374D38119E7;
	Wed, 19 Aug 2026 17:20:56 +0000 (UTC)
Subject: Re: [GIT PULL] watchdog updates for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260817192738.897998-1-linux@roeck-us.net>
References: <20260817192738.897998-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260817192738.897998-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.3
X-PR-Tracked-Commit-Id: 3bbbeb7fddf54a7d7116b2defe0a63a9b583c84e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e1b759c06721bc4e0fdfe5c179b58e7e20d3d13
Message-Id: <178716005535.3599392.7858138176107662935.pr-tracker-bot@kernel.org>
Date: Wed, 19 Aug 2026 17:20:55 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 12:27:37 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e1b759c06721bc4e0fdfe5c179b58e7e20d3d13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
