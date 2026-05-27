Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62171381B12
	for <linux-watchdog@vger.kernel.org>; Wed, 27 May 2026 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899125; cv=none; b=XGmomA2w1w90Pleof3BkJ02RuCLTXNg7ABivNuD6GEoIwfMt+A6b0CXvf0TTTJR4GDovK9P9ZqormOK42M1l8tpouAON3+6S5DNoTiF3BxT85iqa40w6aM/Nn+0IyCcq1Lj9MYgsqusLZxW99ovAvJbRuaaixCIPnhaRmNGmA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899125; c=relaxed/simple;
	bh=Zg6NrUb1Wev61cbAOGx5+UJYTyYbGY+fT47m3rB0Q4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otu1Z/Oq2zPdvNiA+C4Xu9IX9scybrc5vEJGVuyjWn1z4o7gtNU4qHKix72P4+wV6FfGqLSXuexqcf9aKorkLvtnrp7j5xGgm5NlA0Vqw6Tr0XHK+rbQFLgr48InT4Ubo3k2lGDplz76oCqqbgFafWKsoZr85hTw1XWm7rfUYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3PQL/iG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3PQL/iG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248421F00A3D
	for <linux-watchdog@vger.kernel.org>; Wed, 27 May 2026 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779899124;
	bh=Zg6NrUb1Wev61cbAOGx5+UJYTyYbGY+fT47m3rB0Q4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X3PQL/iGFBbVK7K2n9Lsu5zicF5qT01DZq+OIlXcycfAT44LTcEcz3o3q2G/MJZyg
	 BrCr53aoMpcSHPUG0mRVdGjh5WbojDudjhMQiEebjVx1l7T7Re/DsnC9EgWFdrSBIj
	 FufmXEeGrDV/5LeS6PirHsj1RHmM0cm1EuaSs/70IB0nqZ9rbqJr9yR6LlH0+vg2q5
	 zF8jwD62NhKQ7IA2KaZ4R2f/AaiYyr4zCzkjJ3SsU/NaW4XnpP8gdR3v2GxiLqpEcQ
	 T1QH6AEYIz12dqPFiwaL4y4f6ECIL7v7UR/Ezz+a1GJN/dgEAVm+2f2SZ22fZXAruo
	 7uGO8kA54nJfQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a858881ad2so14792443e87.3
        for <linux-watchdog@vger.kernel.org>; Wed, 27 May 2026 09:25:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/qf974WlpX8zwhlo1A4vXvKFapy9/zHmtQ5H/HGQoomGq+LoSbP1pmNmOXCdmj7DX1jkYnukyXgYV5eJrndQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwreL1Pfdh4YfyWcipz/XaSOtvkSwho4+IS9XWJbOiXPDQuvwW1
	cRDCNeh5JJZ8GworbeUuHXk9kic8TXeHYa2A4wfdtOoAQelE/E6b+fWgU2SwBeZPQZYA0+TD4v4
	q3aBLJasZ4WtQHBb/X5CL1R7kRjv1Nr0=
X-Received: by 2002:a05:6512:3b0d:b0:5a8:6793:e701 with SMTP id
 2adb3069b0e04-5aa3238309dmr7207227e87.33.1779899122926; Wed, 27 May 2026
 09:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524022332.179202-1-rosenp@gmail.com> <c6375856-be1b-4c87-9673-e59bd3278718@roeck-us.net>
In-Reply-To: <c6375856-be1b-4c87-9673-e59bd3278718@roeck-us.net>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 27 May 2026 18:25:11 +0200
X-Gmail-Original-Message-ID: <CAD++jLnzv4XHOwN=G5hYdSv8LW3Za6tmz8mw2OAs3NmxKpaRNA@mail.gmail.com>
X-Gm-Features: AVHnY4L3d2ofzJE1WWPuLFZNlQx4mAUALQD5FzWjdiasXqvoQwuMGzXbx8ENUt0
Message-ID: <CAD++jLnzv4XHOwN=G5hYdSv8LW3Za6tmz8mw2OAs3NmxKpaRNA@mail.gmail.com>
Subject: Re: [PATCH] watchdog: core: assign parent with devm registration
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rosen Penev <rosenp@gmail.com>, linux-watchdog@vger.kernel.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 5:22=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:

> I understand that you consider it to be garbage, but in my opinion Sashik=
o has a
> point. If the watchdog device data structure is static, wdd->parent will =
be retained
> over multiple remove/reinsert instantiations of the driver, which in turn=
 would result
> in subsequent UAF. That means I can not accept your patch.

Hm! I wonder if that is a problem for my patch as well. We do have
GPIO dongles that can be plugged in/out repeatedly....

Yours,
Linus Walleij
