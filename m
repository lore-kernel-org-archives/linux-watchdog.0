Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649D32143D
	for <linux-watchdog@vger.kernel.org>; Fri,  3 Jul 2026 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112132; cv=none; b=YVX/BG2zxBpb6ctQo07fCf1ZeseAvaaBtda5XPeBM4xjGlQ7/oJQENi2Fh9KpIq32y1LUAIWqpE6gBWi2wwUGZe2UYgfpk/dWk38QGQacy4HvqnQsn9LkxMA91ydEeeyY22hLcOL/UnGPDqTAolrVflH6wV67YxamKu/YrdbuNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112132; c=relaxed/simple;
	bh=eqVcoD+405XB4dTq9LwwRgrp/fAbdnKCAah/kAR2S0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugJD434zC/OCg0MxBV+z9TcBLou92PR+VAqCwTXTxAQoFsAo6QAPFsT4yexFvSLuBdPkQSsiybUXgOToXQ5QGvCns0Xrv1yughCdTLmheuxg02wiqfo5CxiH0d3NuGWlpnSmxZo9msVBC52HUOmTWHxBAZ2sw/xNNCQyTZ7d3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My/MynzR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My/MynzR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152491F00ADE
	for <linux-watchdog@vger.kernel.org>; Fri,  3 Jul 2026 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783112131;
	bh=eqVcoD+405XB4dTq9LwwRgrp/fAbdnKCAah/kAR2S0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=My/MynzRjxtoUvw7r/ICdgMWdn5C0CLtzkoGiARZflSYt/ca/LUM0+WLZctYsanad
	 +JLMIXExRBh8/0QaEqnjeVMbn9toiw1M/4AeYuqkqWGp2GN6cq7H13f1dRj/pqcYL5
	 diLwEY1wKDRtUxkRmumRiOce+rbDpJotAlC9LV30Gt0lzbyfYLjlwVSiadqSFAYzE8
	 cW89OwxTM0IgRwYUcRX+MN27m/691ywULcqlGk+E65qU5UEETTgfeU+NSgIScbloc2
	 3VNNnJi9irb5mSkR89yA+uGsu2QivseosXPA8GTkDd96GKlusXLTjsu8WpKixCekQM
	 Ui4OrNvfgNf9g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aebf162770so1617432e87.1
        for <linux-watchdog@vger.kernel.org>; Fri, 03 Jul 2026 13:55:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqycVy93AiMKvArWs1Pi2DlGDjjFWP90sD4NHstDjtv5hwQiATvIHbfo4ihe+ljilV9dVx2kfVkDlnwRF6AuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSKuzGYKgXI4n7ExEq5Awfng3lxnazDMnVb/sCe/9E3VTCnbo
	UOl4dis1Q4WV5MMEhSlY5Aa7koOFFxXAM3yzxtmVwErs8vi2G27ToXlOCEiWYVL1T/rVIQVSB5a
	x6D8bkwxIsfXiEIkflPXcm9cPeqvQZdY=
X-Received: by 2002:a05:6512:138e:b0:5ae:cf70:a1b2 with SMTP id
 2adb3069b0e04-5aecf70a286mr1070249e87.21.1783112129834; Fri, 03 Jul 2026
 13:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619-mfd-prcmu-merge-headers-v1-1-8ea0ee23b4d6@kernel.org> <20260702154718.GU2108533@google.com>
In-Reply-To: <20260702154718.GU2108533@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 3 Jul 2026 22:55:17 +0200
X-Gmail-Original-Message-ID: <CAD++jLkrHWhywms9Qkq5LN2vPB-vJu6mD8QHTQVuxRkrERjZVw@mail.gmail.com>
X-Gm-Features: AVVi8CdgKmUkgHMlUvcumMuj83rO54PKjcW-kf8rsm-Rt3X56XnOOTXP4a4_NDA
Message-ID: <CAD++jLkrHWhywms9Qkq5LN2vPB-vJu6mD8QHTQVuxRkrERjZVw@mail.gmail.com>
Subject: Re: [PATCH] mfd: db8500-prcmu: Fold dbx500 header into db8500
To: Lee Jones <lee@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-sound@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 5:47=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:

> I won't hold you to these for this submission, but they're probably
> worth looking at:

I saw them too.

I'm taking this house renovation piece by piece, so this is
kind of prerequisite for the powerdomain change (will send the
MFD part of that once this goes in), then after that
we will find some more etc.

Possibly I can do a bunch in parallell.

Yours,
Linus Walleij
