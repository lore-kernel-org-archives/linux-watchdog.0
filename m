Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E4426EBB;
	Wed, 22 Jul 2026 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753655; cv=none; b=OP9wcXjJGVbK04kGxnQobD+7z1xSF87bVq18jXg4wrnL5AwbbtzZ5m6OkPTgqQeDClyx6CFDxvFAXOqo7NsY8lbs77DOwHxaWgvNjGdsN/gxpR+YVtGHqsT5x0GNAJKkvqLjiVNYyrbSZBPEUAdY4YkznDAGJx8FjUoFhNuGuPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753655; c=relaxed/simple;
	bh=+6anCzUntEI7Yzwi17fmoytkQ7QVI9PtlS2mS3yjrA4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OivpSME4sft7AxA4xhytt009clqQZ0+anfCCfodx0jIIgOt5UPRzfZ0QTqMqF45Knwd3RcsRYXrhp8pnxIUsYzrW/aytgKbHalut6AnUV2bcCT3Cgej6t5QbgDKEKk2M7GDDJ269gGUQK8/Y8/02n04D3BqVbSF5pgyiGLIea+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCf73vNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCf73vNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4BB1F000E9;
	Wed, 22 Jul 2026 20:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784753651;
	bh=iHgWeFntqvEh59BVEffTu2DFa7ewlEGOlm6jb3tsbeo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DCf73vNGbz/0ivZL5opr1cIutVc0z+7IFAbxecpKKvoJCWvXTCK6XZ42rInVMsHkS
	 MY0UwznmPGPjpvvSZvdcTStMgw8rAiAhydiDkA7++hl+2Xkz9mi9/9lCntqhStjEyw
	 ulv2sUywQEcuFQ0wYlL6T3CWU5or4kY7t8AymOxhvDUH2+ji0HI7FYAfySezGk7NNL
	 UFXz9AXWjDRemC0aftPoiaYTm8VQJDkPlqIP4lEyL0DOcROinKkiWZbh5eutmCJnzP
	 4pdjY0ZcHw+X5pxiLd8sN4KJxx6NzJc7mEBKjFAg0Ik6V9VdWZ9enR6k35M3kbu2Cz
	 A1h1XYQMA79Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9AE6A380CED4;
	Wed, 22 Jul 2026 20:53:41 +0000 (UTC)
Subject: Re: [GIT PULL] watchdog fixes for v7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260722165740.2307124-1-linux@roeck-us.net>
References: <20260722165740.2307124-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260722165740.2307124-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.2-rc5
X-PR-Tracked-Commit-Id: bcfcd7619f277842430d197556463b401b839ee9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08de7d9d2479ca2acb296bc9e43eba1020879c3e
Message-Id: <178475362052.2020310.8088603050966521038.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jul 2026 20:53:40 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 Jul 2026 09:57:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-v7.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08de7d9d2479ca2acb296bc9e43eba1020879c3e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
