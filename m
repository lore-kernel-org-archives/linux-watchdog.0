Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14FE2DA756
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230711; cv=pass; b=fbWMx2e9J+/pJC+BBlh7SMqUmmugAF2cT2jQA+kWNJGX1lt9H5beQ7j2imKn+A0fgh2SgVNxAPUQlmni6Rzey8PfqKoG2blbZbOtsIKpm71LZM4AsXvqRKqBUonJbCgbJCU9G6Fb+RgKdbTSfjO48T2EMXocdlPUFAgAr+EdGRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230711; c=relaxed/simple;
	bh=8Um1FgXxiTwMWWzJYudyAqHH7fK2btRR+xiy3qjpPLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCFMRCjktuLAPXERukIYIgR2QKirT19c+DdksPofPD+eVCqXYAiIUGG7DhXSropjROycRIqYnIbUpyocJfQB0DNbqmTunvF2WOi8CupmkS9/Y9cUfv3I3nbdhOMNSxN1VKhYkZPh8KNuYtmbsPKYbH2mGNHVsf0kLorMGzTYhHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiDprxd9; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiDprxd9"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a887ebb416so5082498e87.2
        for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 15:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779230708; cv=none;
        d=google.com; s=arc-20240605;
        b=ArahfxkWxZhj0gK+5hoZiGrP78uj8JPyxcTlM317jPEVZcGfpKdem2ZYLH4JrJmNK6
         mqv0FhLh3JIn2VeN92yGcp5H7RJDDdeXS25DNEwE44gDAvDsSgoFKx+Who/eLH2JArPk
         nogyULxwrbeBvq0ktFnjl4nb3ZRIzeukOtItGERIwEi76pQB5Zy2rQ7Hk5bumQpLa/iM
         dvrBOK7DT95a0uZ8A7P93ohKu5SARBt/jus5eLGxvrQI1cx49qczc7jJ95zTSj4d593G
         IapowGbWfYU1pDFVaDYvlX00Qh44B6IyPCObd8R27wvsTG+m5c7WycoMPkWCexPR/+eX
         7e5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fNaftevW6VPvIvu9pnZH1/k+uCUihxPpTdW+UWd+Vao=;
        fh=FJE0Z1GZdAMudjUr2H6FLc0DWrHWA8QakvIVOuQqiKg=;
        b=Z0cPIDfPbolMJC40rPTovChJmt7xTuDYLGYPHuCGC6+0aB1Hyhp1A+yeVddij1ZKQR
         dyLoz4nJJb3BOojUKtAYIiysi2Z0Sl8Te32OMfHSTxN2ULuYhgYGl+3ehkfcOB0tLME+
         KTWRpBajmyfbd1NXmA/WKAgX55RMmq4mDo+BBy7bUzaCGHK2tfAJrmBf4+vTQYW2eyqn
         AJYsX1KFNxDpWUTDI9ytZekDsWKSF/yx72FtdbRalgr5gVBGcpStE9fueDPl1QwDLpmc
         jUsA/DHpkxcZg7PGpqQTEyQv6eU0tN8xbNwGNzxOShjArbaHYxIGR+UxyacpRDG/6fEV
         1Yvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779230708; x=1779835508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNaftevW6VPvIvu9pnZH1/k+uCUihxPpTdW+UWd+Vao=;
        b=eiDprxd99w2hUpp1fk/C1YTeZMe8XtbhvOQVHYyzISnbaD3t6KO4PRSwTW1LvspE3h
         S+8yLHLr8uW6UWsXCQwHd3a9F0qzk6TTLDkrr7VmNfLYf8G8tD8m1HULkwSzop3C3tTB
         +iUWdAoizQa9h0WvYYWBmFj/Lo83SojNWf1fS/EzgdUi+N3gdLPeiYSXZIAOyVUY89GT
         olhrS6pFqj4Eew5YwpVbzHkBFYGH4WSOPWuTrAJYJKl+t4PF8hczXqRClV2VFdd4VWQr
         ob9VR9TfuQogmQU2nOwZ6AIBhCNMPDj9HBmUzYqa04c1FTZ2VGeNdPs/r6IGzj4BnjHQ
         fP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779230708; x=1779835508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNaftevW6VPvIvu9pnZH1/k+uCUihxPpTdW+UWd+Vao=;
        b=iFTQCMB7Irq9sAeMehE8srK1qmVSgKY/sYIzwHw6qKAa46LepGQF79koj4DdTV2+iE
         HdjqfDhAUmnY3uX4l3SXRN19NM/Rl80oyaaetBd19mABxl8ZXe2ot2mBPUVKvk7CQzyQ
         +NLJWMC/J8kEJwVO5SCBPxsmS874fQjZOq89f61GOSfaUKX0E/Od8c+ObqvJv1qURftO
         Iseils/4XAHPGRrugUm+CL3GBvYW7GrRqQyzqvqnQS3CqXCrJBG6z3neWReLnqWs9LxY
         OqImV2WnOdi8UnvBF/apVXkTDqmifhhKOHNIYrdbB3chChZQIotiMKYeGoX14dP+1U+w
         4MqA==
X-Gm-Message-State: AOJu0Yxs/+3/0vSMBxZ00VA2+51xyafS7lf2N9iI4HqVF3ROs1uS6I2S
	ecaw5edBjm3KLxhK2U+ejcE1L5cpdLqn6YIJ1z0gRt/VbWb+EdbtKDfXcZjoQaSRJiaN1Uv+ohz
	yvb6CNAkQNBijN1fDQ9JHxHQ1fN/2NhnbFv0f
X-Gm-Gg: Acq92OFql6a5eVlqMxNAX/FjAJ1Eb4e5Y1J3cFRdAW99wTcjzvIsCZb+qjwJYUAqND+
	QVhPKSmdq86KVx8RQFgvuKNFMtbfXpeaOv4JKiY0CMFYA3qesHNoREWXyffR+ubeRGDy8fHS6tS
	ixQKQhMzW0SX9wT+/D7ZDD5lWaqbJnzxODGA41CN95dK+8dOcGJP9gC01Q7ErjR8i0OpbQoeQzL
	Pvoa/N9FwKOScl55hJw8f8SUBSgIQhhHbnupxiFOlgOiPmPYmhCpL1F76wQPc5eZ32n6hejkMYK
	ASL367hMyw+5Yz+Myac3C8aRT0CYSCD8RSh9/GvgxqIE8zUbV86YQ4WJ1rrYQ7KLfn4a+j5idg/
	Ep/w5BUDkTL7COAyNXYEFRdu6RDCJBhyknhWdF7/aVXDjDXJxZEJey/Q9GiIGXJWrLs8O
X-Received: by 2002:a05:6512:a83:b0:5a8:9135:127f with SMTP id
 2adb3069b0e04-5aa0e623e0cmr5202134e87.17.1779230707823; Tue, 19 May 2026
 15:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519214229.16656-1-rosenp@gmail.com> <61a24e1e-2490-4791-811a-3c1c85fda05b@roeck-us.net>
In-Reply-To: <61a24e1e-2490-4791-811a-3c1c85fda05b@roeck-us.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 19 May 2026 15:44:56 -0700
X-Gm-Features: AVHnY4Jmq-Gj0w96_7kE0dECzt6euGistVPLkr1BGJqS8MSyRu3W_EC_DZePkUU
Message-ID: <CAKxU2N8pzaWow-pQ=gTkyvD=4JpZF77SN7F9pF9Ty78vkj65xQ@mail.gmail.com>
Subject: Re: [PATCH] watchdog: orion_wdt: Use devm APIs for clock and watchdog management
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:34=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Tue, May 19, 2026 at 02:42:29PM -0700, Rosen Penev wrote:
> > Replace clk_get/clk_prepare_enable/clk_put with devm_clk_get_enabled
> > and devm_clk_get_optional_enabled so the clock lifecycle is managed
> > automatically. Switch to devm_watchdog_register_device to eliminate
> > the manual remove callback and the disable_clk error path.
> >
> > Switching to devm in these functions is fine as the proper
> > platform_device is passed in.
> >
> > Assisted-by: Claude:Sonnet-4.6
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> drivers/watchdog/orion_wdt.c: In function 'orion_wdt_clock_init':
> drivers/watchdog/orion_wdt.c:82:13: error: unused variable 'ret' [-Werror=
=3Dunused-variable]
>    82 |         int ret;
>       |             ^~~
> drivers/watchdog/orion_wdt.c: In function 'armada370_wdt_clock_init':
> drivers/watchdog/orion_wdt.c:95:13: error: unused variable 'ret' [-Werror=
=3Dunused-variable]
>    95 |         int ret;
>       |             ^~~
> drivers/watchdog/orion_wdt.c: In function 'armada375_wdt_clock_init':
> drivers/watchdog/orion_wdt.c:113:13: error: unused variable 'ret' [-Werro=
r=3Dunused-variable]
>   113 |         int ret;
>       |             ^~~
> drivers/watchdog/orion_wdt.c: In function 'armadaxp_wdt_clock_init':
> drivers/watchdog/orion_wdt.c:144:13: error: unused variable 'ret' [-Werro=
r=3Dunused-variable]
>   144 |         int ret;
>
> On top of that, the APIs are not 1:1 replaceable.
>
> I am so tired of this. Please stop. I am no longer going to accept any "c=
leanup"
> patches.
If I don't, the bot yells at me. If I do, you yell at me. It seems I
am at an impasse.
>
> Guenter
