Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD283806D2;
	Tue, 25 Aug 2026 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688104; cv=none; b=VvEXPqHQW6oAhdczdTcjtv7/VjiLRYeLb0NE/Mny6HrSBNordyaeuvYx5EVJB16nm/Qn4UpwE0/ZpWLkwTLeEBhzp3tPyeyGUtUvqK2nE2ph/GHENVhYxhmDUORss8GhBLT/DmF6z49Z2kwU/32JoR3LvWYhF48P1jJmn79m+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688104; c=relaxed/simple;
	bh=3chy/HcnVBMhhr5qvvFytuYaCA1gib5BRuzuSIaNLE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ShALc66h8OYYlPCiFsHJVahsokw+2Vic4drNYPpBCI2JY4La7NdlwY3zNjnUyX4Lg3V4WjO9f7hBR2yvp2+e9awsfrJBBrgNhNV5G3ygbVRjQlrk2q7K4DNHx+nmU6dyLxHVb2xuSWdVxvsGWHuOlD+6q/qdAJQzsqelMbJtRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX/EJ3dC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX/EJ3dC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6B41F000E9;
	Tue, 25 Aug 2026 20:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787688102;
	bh=i/9fr3QGe6o/MrBjROnoUVWteonOveyd6QVH/D/4RgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HX/EJ3dCzIgLbwUxZZN8g/bpaeFy7O4Bn7WU3rTgei1NLbcITqoigj4vFUnjwiF+M
	 0236dSoTmXStFQgVW1WfCwIiVvlNOUOzlu0WDO4eKfRuBjVXQeJC3Mhkj1MZhTX63G
	 itJWXm/LrZINx0EZG3o+0dLXvOMgfgYGmzcFjf1PngsHIL5VS18WwCOeRnzN6CftPR
	 TVKem5Syv9fWe+OiaTu5uED55zOh6aukr+5xIwVTZ2jWhq830OMhLiR2pp1H+14a+B
	 tbkrPLAvtqS484LUUQFPQSA4b0e6wEwcztQVlQb9RMNv09V9GYs0VANgRitPmlcD65
	 yOBlH0NcGywZw==
From: Thomas Gleixner <tglx@kernel.org>
To: Mayank Rungta <mrungta@google.com>
Cc: Doug Anderson <dianders@chromium.org>, Guenter Roeck
 <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>
Subject: Re: [PATCH 2/3] genirq: Export NMI APIs
In-Reply-To: <CABz7rdCKHcXx6U5qo83HaiR_b17CsoQoVVEiZ=03c+h2FUFHpA@mail.gmail.com>
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
 <20260730-qcom-wdt-nmi-series-v1-2-3aa86d162914@google.com>
 <CAD=FV=V+nrmtK6FJ2G+LGnvxkLEWMR+2A253-gQ2smxf9LoEWg@mail.gmail.com>
 <eddc90dc-3223-4356-9e9b-350af904b144@roeck-us.net>
 <CAD=FV=XuCHdOv8kct63JzmbgjxJMxL7fc75KtAQL0hbJc7_v0w@mail.gmail.com>
 <87h5l5ex9r.ffs@fw13>
 <CABz7rdCKHcXx6U5qo83HaiR_b17CsoQoVVEiZ=03c+h2FUFHpA@mail.gmail.com>
Date: Tue, 25 Aug 2026 22:01:40 +0200
Message-ID: <87cxv6geaj.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24 2026 at 17:00, Mayank Rungta wrote:
> On Fri, Aug 7, 2026 at 9:00=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> =
wrote:
>> Sorry, I did not pay attention as I was AFK and busy with bugs. I'll
>> have a look once the dust settles on my side (hopefully soonish).
>>
>
> Hi Thomas,
>
> Friendly ping on this thread!
>
> I completely understand maintainer schedules are very busy. If you
> haven't had a chance to look at this by the end of the week, I'm happy
> to take a stab at implementing the NMI teardown synchronization in v2
> myself for your review.
>
> Please let me know if you have any thoughts or guidance on the approach.

I'm stuck in regressions, security fixes and I try to maintain some
private life aside of that. I surely have opinions, but I probably won't
come around to write them down before next week. Feel free to do a v2
and I'll go and look at that.

Thanks,

        tglx
