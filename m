Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5F4E2F13
	for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584157; cv=none; b=DP8BvxeE/kD27h0Ef/P6iflgB+g3DXuuQGrUHuuSQqlnbvD/t6lXtyPnn9q11Gbb7kKwyY7OVciiLGV6alwKwOIQm8F8VyzqzEcDircjimUFLeJlvC8TPvPJPW/Nhr2TArSBkY6QgZzmAtq2ojWXKLoNnXMYfOalGUAKZ15fCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584157; c=relaxed/simple;
	bh=L8wo5FApDByENFzUWm5cl4G6slLikHN6feJMUainjSY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZxHa5bz7ApIZoddUs9FCx9qvcH+/TAYyq2f0g4diCMqNQ5TfFFAq81mom6jE3t75EiqDzKjMvxcdykU8Jkjq45zwWQr0MaT7XQOhi+EMhwkgpsAa4sbAsU42cS33EX7QdeJOjghg5Omt3Dnltmb7VEwDqnJE4pDP0uPYt5MMKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRn3jv5z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRn3jv5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF411F00893;
	Wed, 16 Sep 2026 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584135;
	bh=g0od0Yqw7EZ8wi5SxStxjm+IOGuUx2/wtagIwpu3l+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRn3jv5zgN4igwe8dKxzISAmVTBoPsbq8O858kcK9/qoAIDhHirZd8gzHnKZiYTPB
	 S/yPvaFRFSYF3X4MzspaWQefIVtbsLDuf/Iz+/EFqmND3O5NiSj+TLBpHIebq0PbsA
	 K1M/RlgI1PD3ph6OzESLSW1D6t3u9cy4wgBGn2icKsOreYC7CsHqmKTrdClEZTBScN
	 oZ/Vy1zyxPAkbrwGVZU+duBixGJ/pCG68VknQZm0IhqoZv1IuWyZQdLRNorqja9KSU
	 JIDA33PJ3iV8zmfhsTl7hbNi5bpkDl1okE87KmA4tZ93BG3Okcorkv2OxrUoWgxaPF
	 fbeelRFJmOUXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] panic: fix redirect CPU race in
 panic_try_force_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bradley Morgan" <brads@mainlining.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260916182957.7788-2-brads@mainlining.org>
References: <20260916182957.7788-1-brads@mainlining.org>
 <20260916182957.7788-2-brads@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:42:15 +0000
Message-Id: <20260916184215.8FF411F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] panic: concurrent panics lose crash state due to early offline
--

commit 28c5124dccd2314d2c1eb6f5688411f6a774d048
Author: Bradley Morgan <brads@mainlining.org>

panic: fix redirect CPU race in panic_try_force_cpu()

The commit updates panic_try_force_cpu() to handle cmpxchg race losers
by returning true so that they stop and don't proceed to panic(). It also
adds a check for panic_in_progress() to correctly stop the CPU if panic
is already running on another CPU.

Closes: https://sashiko.dev/#/patchset/20260705164123.18746-1-include@grrlz=
.net
Closes: https://sashiko.dev/#/patchset/20260707172252.4842-1-include@grrlz.=
net

> diff --git a/kernel/panic.c b/kernel/panic.c
> index 213725b612aa1..010b331658b6b 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c

[ ... ]

> @@ -396,16 +397,20 @@ static bool panic_try_force_cpu(const char *fmt, va=
_list args)
>  		return false;
>  	}
> =20
> -	/* Another panic already in progress */
> +	/*
> +	 * Don't redirect when a panic is already in progress. Stop this
> +	 * CPU when it's another one, proceed when it's this one.
> +	 */
>  	if (panic_in_progress())
> -		return false;
> +		return panic_on_other_cpu();

[Severity: High]
When panic is claimed by another CPU, panic_try_force_cpu() returns true and
causes the caller to mark this CPU offline. Does this hide the CPU from the
kdump NMI shootdown?

If multiple CPUs panic simultaneously, the caller in vpanic() blindly sets
the CPU offline for all 'true' returns:

kernel/panic.c:vpanic() {
    ...
	if (panic_try_force_cpu(fmt, args)) {
		set_cpu_online(smp_processor_id(), false);
		panic_smp_self_stop();
	}
    ...
}

Will this cause kdump NMI shootdown to bypass these offline CPUs (e.g., via
cpu_online_mask iteration or aborting early when num_online_cpus() < 2),
resulting in their CPU registers and backtraces being permanently omitted f=
rom
the crash dump?

> =20
>  	/*
> -	 * Only one CPU can do the redirect. Use atomic cmpxchg to ensure
> -	 * we don't race with another CPU also trying to redirect.
> +	 * Only one CPU can do the redirection. Others should go offline.
> +	 * Continue with panic() when we already tried the redirection
> +	 * from this CPU before, for example via nmi_panic().
>  	 */
>  	if (!atomic_try_cmpxchg(&panic_redirect_cpu, &old_cpu, this_cpu))
> -		return false;
> +		return old_cpu !=3D this_cpu;

[Severity: High]
Similarly, if this CPU loses the redirect cmpxchg race, this returns true.
Does this also cause vpanic() to erroneously set this CPU offline, preventi=
ng
kdump from capturing its crash state?

> =20
>  	/*
>  	 * Use dynamically allocated buffer if available, otherwise

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916182957.7788=
-1-brads@mainlining.org?part=3D1
