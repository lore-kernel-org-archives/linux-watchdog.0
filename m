Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F853F660F
	for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588158; cv=none; b=iJR7jX8c44sh22aarXvF7QOC5KxInHy5rPqNOcH9IM3GO01khDIp06Lj7+Nsawg3OsYqqDNeNUrwJqvc/7t9cO4n8fCsjgnL/mDK3H4y2xmGegxQWopQf6QzLfvQYG3sjreoDB9FfNmzmhfEAwbk+efyv/2zagXl3ZzdpkmNOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588158; c=relaxed/simple;
	bh=c77N+78fgkedUXLRJmai0uajqy0d2GDHJd57znGFzvw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dpGDgnKV9ecPtJGwJ1bEIgNmFAbJo3gFrh7ARu8AVoaKWegXYhgRsiXmBD1UkCygHl7+s3AtmcOEuPDMVZLXP7NiDov9aFPoY/8F8y1YRD+i79Ldbw7rjTJAYGkPmed7mILzZX2ZjRjsi6qbFoyY0h6ez510hE8xy9ZLmiclvWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=hsSJFiuE; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=fjkfJ4KO; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="hsSJFiuE";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="fjkfJ4KO"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789588125; bh=ogtQwEl/mZDAf2aPeNrZZyl
	fhFFTC1ZXf6rai8t0KsU=; b=hsSJFiuEZLraYJy8CQEhWIBZqBjonPicNPd3o4HLtAW5AYHDrx
	X7BVw5dDUGMmTimtNxyq8vW0mWXgekCSRC6X/V8Owwzf1qlgmME4Gm+JCybJiuPT0Rbop0LsfGg
	/hFJn5KF6B0J4d+7TNdKQ900EsBUDO98Jdwj7HaZfTCU6+CZ7WGAvit5V/VWHWRKz3TZCG5UBlV
	/5g0XYKFDb65gqESfljynDRNTdWRhhXfqtKZpyMf32Vhowgx+J5a5CxKV/YgSdfHcoIrG90IXaw
	p1G/Z1UxN9/7skVQ26SfRrF3YkCbJE4de5sEDrK/s6kKmKQ7Akun1clJXYtfbNlPLPA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1789588125; bh=ogtQwEl/mZDAf2aPeNrZZyl
	fhFFTC1ZXf6rai8t0KsU=; b=fjkfJ4KOhyfMX7UMamomHqh0lOuUb9NZn46jS6ayiPlqpigNle
	fG/Qs1b7O7aIbXBTyE99vtsxqyi+pW3fVDAg==;
Date: Wed, 16 Sep 2026 20:48:43 +0100
From: Bradley Morgan <brads@mainlining.org>
To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
CC: linux-watchdog@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_1/6=5D_panic=3A_fix_redire?=
 =?US-ASCII?Q?ct_CPU_race_in_panic=5Ftry=5Fforce=5Fcpu=28=29?=
In-Reply-To: <20260916184215.8FF411F00893@smtp.kernel.org>
References: <20260916182957.7788-1-brads@mainlining.org> <20260916182957.7788-2-brads@mainlining.org> <20260916184215.8FF411F00893@smtp.kernel.org>
Message-ID: <C40F4EE1-CA84-4079-9C25-5EE300B7C787@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 16 September 2026 19:42:15 BST, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential
>issue(s) to consider:
>- [High] panic: concurrent panics lose crash state due to early offline
>--
>
>commit 28c5124dccd2314d2c1eb6f5688411f6a774d048
>Author: Bradley Morgan <brads@mainlining.org>
>
>panic: fix redirect CPU race in panic_try_force_cpu()
>
>The commit updates panic_try_force_cpu() to handle cmpxchg race losers
>by returning true so that they stop and don't proceed to panic(). It also
>adds a check for panic_in_progress() to correctly stop the CPU if panic
>is already running on another CPU.
>
>Closes: https://sashiko.dev/#/patchset/20260705164123.18746-1-include@grrlz.net
>Closes: https://sashiko.dev/#/patchset/20260707172252.4842-1-include@grrlz.net
>
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index 213725b612aa1..010b331658b6b 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>
>[ ... ]
>
>> @@ -396,16 +397,20 @@ static bool panic_try_force_cpu(const char *fmt,
>va_list args)
>>  		return false;
>>  	}
>>  
>> -	/* Another panic already in progress */
>> +	/*
>> +	 * Don't redirect when a panic is already in progress. Stop this
>> +	 * CPU when it's another one, proceed when it's this one.
>> +	 */
>>  	if (panic_in_progress())
>> -		return false;
>> +		return panic_on_other_cpu();
>
>[Severity: High]
>When panic is claimed by another CPU, panic_try_force_cpu() returns true
>and
>causes the caller to mark this CPU offline. Does this hide the CPU from
>the
>kdump NMI shootdown?
>
>If multiple CPUs panic simultaneously, the caller in vpanic() blindly sets
>the CPU offline for all 'true' returns:
>
>kernel/panic.c:vpanic() {
>    ...
>	if (panic_try_force_cpu(fmt, args)) {
>		set_cpu_online(smp_processor_id(), false);
>		panic_smp_self_stop();
>	}
>    ...
>}
>
>Will this cause kdump NMI shootdown to bypass these offline CPUs (e.g.,
>via
>cpu_online_mask iteration or aborting early when num_online_cpus() < 2),
>resulting in their CPU registers and backtraces being permanently omitted
>from
>the crash dump?
>
>>  
>>  	/*
>> -	 * Only one CPU can do the redirect. Use atomic cmpxchg to ensure
>> -	 * we don't race with another CPU also trying to redirect.
>> +	 * Only one CPU can do the redirection. Others should go offline.
>> +	 * Continue with panic() when we already tried the redirection
>> +	 * from this CPU before, for example via nmi_panic().
>>  	 */
>>  	if (!atomic_try_cmpxchg(&panic_redirect_cpu, &old_cpu, this_cpu))
>> -		return false;
>> +		return old_cpu != this_cpu;
>
>[Severity: High]
>Similarly, if this CPU loses the redirect cmpxchg race, this returns true.
>Does this also cause vpanic() to erroneously set this CPU offline,
>preventing
>kdump from capturing its crash state?
>
>>  
>>  	/*
>>  	 * Use dynamically allocated buffer if available, otherwise
>
>
Oh god sake there wasn't a issue in like the last 5 versions
--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
